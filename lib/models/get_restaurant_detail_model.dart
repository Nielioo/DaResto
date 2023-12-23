part of 'models.dart';

GetRestaurantDetail getRestaurantDetailFromJson(String str) => GetRestaurantDetail.fromJson(json.decode(str));

String getRestaurantDetailToJson(GetRestaurantDetail data) => json.encode(data.toJson());

class GetRestaurantDetail {
    bool error;
    String message;
    RestaurantDetail restaurant;

    GetRestaurantDetail({
        required this.error,
        required this.message,
        required this.restaurant,
    });

    factory GetRestaurantDetail.fromJson(Map<String, dynamic> json) => GetRestaurantDetail(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetail.fromJson(json["restaurant"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
    };
}