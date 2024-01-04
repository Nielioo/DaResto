part of '../services.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.openBox<String>(Const.hiveFavoriteRestaurantBox);
    await Hive.openBox<bool>(Const.hiveScheduleBox);
  }

  static Future<void> close() async {
    await Hive.close();
  }
}
