part of 'providers.dart';

class DatabaseProvider extends ChangeNotifier  {
  void saveFavoriteRestaurant({required RestaurantList restaurant}) async {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    final restaurantJson = restaurant.toJson();
    await hiveRestaurant.put(restaurant.id, restaurantJson as String);
  }

  List<RestaurantList> getAllFavoriteRestaurant() {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    return hiveRestaurant.values
        .map((item) => RestaurantList.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  void deleteFavoriteRestaurant({required String restaurantId}) async {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    await hiveRestaurant.delete(restaurantId);
  }

  bool isFavoriteRestaurantExist({required String restaurantId}) {
    final hiveRestaurant = Hive.box<String>(Const.hiveFavoriteRestaurantBox);
    return hiveRestaurant.containsKey(restaurantId);
  }
}
