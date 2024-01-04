part of 'providers.dart';

class FavoriteRestaurantProvider extends ChangeNotifier {
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  DataState? _state;
  DataState? get state => _state;

  List<RestaurantList> restaurantFavoriteList = [];

  List<RestaurantList> searchedFavoriteRestaurants = [];

  void saveFavoriteRestaurant({required RestaurantList restaurant}) async {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    final restaurantJson = jsonEncode(restaurant);
    await hiveRestaurant.put(restaurant.id, restaurantJson);
    getAllFavoriteRestaurant();
    notifyListeners();
  }

  void getAllFavoriteRestaurant() {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    restaurantFavoriteList = hiveRestaurant.values
        .map((item) => RestaurantList.fromJson(jsonDecode(item)))
        .toList();
    notifyListeners();
  }

  void getFavoriteRestaurantByQuery(String query) {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    if (hiveRestaurant.values.isNotEmpty) {
      _state = DataState.hasData;
      final values = hiveRestaurant.values
          .map((item) => RestaurantList.fromJson(jsonDecode(item)))
          .where((restaurant) =>
              restaurant.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      searchedFavoriteRestaurants = values;
      notifyListeners();
    } else {
      _state = DataState.noData;
      searchedFavoriteRestaurants = [];
      notifyListeners();
    }
  }

  void deleteFavoriteRestaurant({required String restaurantId}) async {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    await hiveRestaurant.delete(restaurantId);
    getAllFavoriteRestaurant();
    notifyListeners();
  }

  bool isFavoriteRestaurantExist({required String restaurantId}) {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    final values = hiveRestaurant.containsKey(restaurantId);
    return values;
  }
}
