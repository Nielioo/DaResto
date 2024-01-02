part of 'providers.dart';

class DatabaseProvider extends ChangeNotifier {
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
