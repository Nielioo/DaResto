part of 'models.dart';

GetCustomerReview getCustomerReviewFromJson(String str) => GetCustomerReview.fromJson(json.decode(str));

String getCustomerReviewToJson(GetCustomerReview data) => json.encode(data.toJson());

class GetCustomerReview {
    bool error;
    String message;
    List<CustomerReview> customerReviews;

    GetCustomerReview({
        required this.error,
        required this.message,
        required this.customerReviews,
    });

    factory GetCustomerReview.fromJson(Map<String, dynamic> json) => GetCustomerReview(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
    };
}