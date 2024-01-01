part of 'providers.dart';

class DatabaseProvider extends ChangeNotifier {
  void saveFavoriteRestaurant({required RestaurantList restaurant}) async {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    final restaurantJson = restaurant.toJson();
    await hiveRestaurant.put(restaurant.id, restaurantJson as String);
    notifyListeners();
  }

  List<RestaurantList> getAllFavoriteRestaurant() {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    notifyListeners();
    return hiveRestaurant.values
        .map((item) => RestaurantList.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  void deleteFavoriteRestaurant({required String restaurantId}) async {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    await hiveRestaurant.delete(restaurantId);
    notifyListeners();
  }

  bool isFavoriteRestaurantExist({required String restaurantId}) {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    notifyListeners();
    return hiveRestaurant.containsKey(restaurantId);
  }
}
