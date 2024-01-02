part of 'providers.dart';

class FavoriteRestaurantProvider extends ChangeNotifier {
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  final ValueNotifier<List<RestaurantList>> searchedFavoriteRestaurants =
      ValueNotifier([]);

  void saveFavoriteRestaurant({required RestaurantList restaurant}) async {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    final restaurantJson = jsonEncode(restaurant);
    await hiveRestaurant.put(restaurant.id, restaurantJson);
    notifyListeners();
  }

  List<RestaurantList> getAllFavoriteRestaurant() {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    final values = hiveRestaurant.values
        .map((item) => RestaurantList.fromJson(jsonDecode(item)))
        .toList();
    notifyListeners();
    return values;
  }

  List<RestaurantList> getFavoriteRestaurantByQuery(String query) {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    final values = hiveRestaurant.values
        .map((item) => RestaurantList.fromJson(jsonDecode(item)))
        .where((restaurant) => restaurant.name.contains(query))
        .toList();
    notifyListeners();
    return values;
  }

  void deleteFavoriteRestaurant({required String restaurantId}) async {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    await hiveRestaurant.delete(restaurantId);
    notifyListeners();
  }

  bool isFavoriteRestaurantExist({required String restaurantId}) {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    final values = hiveRestaurant.containsKey(restaurantId);
    notifyListeners();
    return values;
  }
}
