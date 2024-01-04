import 'package:daresto/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  group('Restaurant List API Test', () {
    group('Get Restaurant List', () {
      test('Should be able to parse GetRestaurantListFromJson from json',
          () async {
        final response = await http
            .get(Uri.parse('https://restaurant-api.dicoding.dev/list'));

        if (response.statusCode == 200) {
          GetRestaurantList result = GetRestaurantListFromJson(response.body);
          expect(result.error, false);
          expect(result.message, "success");
          expect(result.count, 20);
          expect(result.restaurants, isA<List<RestaurantList>>());
        } else {
          throw Exception('Failed to load restaurant list');
        }
      });
    });

    group('Get Restaurant Detail', () {
      test('Should be able to parse getRestaurantDetailFromJson from json',
          () async {
        final response = await http.get(Uri.parse(
            'https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867'));

        if (response.statusCode == 200) {
          GetRestaurantDetail result =
              getRestaurantDetailFromJson(response.body);
          expect(result.error, false);
          expect(result.message, 'success');
          expect(result.restaurant.id, 'rqdv5juczeskfw1e867');
          expect(result.restaurant.name, 'Melting Pot');
          expect(result.restaurant.description, isA<String>());
          expect(result.restaurant.city, 'Medan');
          expect(result.restaurant.address, 'Jln. Pandeglang no 19');
          expect(result.restaurant.pictureId, '14');
          expect(result.restaurant.categories, isA<List<Category>>());
          expect(result.restaurant.menus, isA<Menus>());
          expect(result.restaurant.rating, 4.2);
          expect(
              result.restaurant.customerReviews, isA<List<CustomerReview>>());
        } else {
          throw Exception('Failed to load restaurant detail');
        }
      });
    });

    group('Get Restaurant Search', () {
      test('Should be able to parse restaurantSearchFromJson from json',
          () async {
        final response = await http.get(
            Uri.parse('https://restaurant-api.dicoding.dev/search?q=kafe'));

        if (response.statusCode == 200) {
          RestaurantSearch result = restaurantSearchFromJson(response.body);
          expect(result.error, false);
          expect(result.founded, 4);
          expect(result.restaurants.length, 4);
          expect(result.restaurants[0].id, 's1knt6za9kkfw1e867');
          expect(result.restaurants[0].name, 'Kafe Kita');
          expect(result.restaurants[0].description, isA<String>());
          expect(result.restaurants[0].pictureId, '25');
          expect(result.restaurants[0].city, 'Gorontalo');
          expect(result.restaurants[0].rating, 4);
        } else {
          throw Exception('Failed to load restaurant search');
        }
      });
    });
  });
}