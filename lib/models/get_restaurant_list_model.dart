// ignore_for_file: non_constant_identifier_names

part of 'models.dart';

GetRestaurantList GetRestaurantListFromJson(String str) =>
    GetRestaurantList.fromJson(json.decode(str));

String GetRestaurantListToJson(GetRestaurantList data) =>
    json.encode(data.toJson());

class GetRestaurantList {
  bool error;
  String message;
  int count;
  List<RestaurantList> restaurants;

  GetRestaurantList({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory GetRestaurantList.fromJson(Map<String, dynamic> json) =>
      GetRestaurantList(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<RestaurantList>.from(
            json["restaurants"].map((x) => RestaurantList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
