import 'package:daresto/models/models.dart';
import 'package:daresto/services/services.dart';
import 'package:daresto/shared/shared.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'restaurant_api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('RestaurantApiService', () {
    final client = MockClient();
    final apiService = RestaurantApiService(client: client);

    test('returns a restaurant list if the http call completes successfully',
        () async {
      when(client.get(Uri.parse('${Const.baseUrl}/list'))).thenAnswer(
          (_) async => http.Response(
              '{"restaurants": [{"id": "1", "name": "Restaurant 1"}]}', 200));

      expect((await apiService.getRestaurantList()).restaurants,
          isA<List<RestaurantList>>());
    });

    test('returns a restaurant detail if the http call completes successfully',
        () async {
      when(client.get(Uri.parse('${Const.baseUrl}/detail/1'))).thenAnswer(
          (_) async => http.Response(
              '{"restaurant": {"id": "1", "name": "Restaurant 1"}}', 200));

      expect((await apiService.getRestaurantDetail("1")).restaurant,
          isA<RestaurantList>());
    });

    test(
        'returns a restaurant search result if the http call completes successfully',
        () async {
      when(client.get(Uri.parse('${Const.baseUrl}/search?q=test'))).thenAnswer(
          (_) async => http.Response(
              '{"restaurants": [{"id": "1", "name": "Restaurant 1"}]}', 200));

      expect((await apiService.getRestaurantSearch("test")).restaurants,
          isA<List<RestaurantList>>());
    });
  });
}


// void main() {
//   group('Restaurant List API Test', () {
//     group('Get Restaurant List', () {
//       test('Should be able to parse GetRestaurantListFromJson from json',
//           () async {
//         final response = await http
//             .get(Uri.parse('https://restaurant-api.dicoding.dev/list'));

//         if (response.statusCode == 200) {
//           GetRestaurantList result = GetRestaurantListFromJson(response.body);
//           expect(result.error, false);
//           expect(result.message, "success");
//           expect(result.count, 20);
//           expect(result.restaurants, isA<List<RestaurantList>>());
//         } else {
//           throw Exception('Failed to load restaurant list');
//         }
//       });
//     });

//     group('Get Restaurant Detail', () {
//       test('Should be able to parse getRestaurantDetailFromJson from json',
//           () async {
//         final response = await http.get(Uri.parse(
//             'https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867'));

//         if (response.statusCode == 200) {
//           GetRestaurantDetail result =
//               getRestaurantDetailFromJson(response.body);
//           expect(result.error, false);
//           expect(result.message, 'success');
//           expect(result.restaurant.id, 'rqdv5juczeskfw1e867');
//           expect(result.restaurant.name, 'Melting Pot');
//           expect(result.restaurant.description, isA<String>());
//           expect(result.restaurant.city, 'Medan');
//           expect(result.restaurant.address, 'Jln. Pandeglang no 19');
//           expect(result.restaurant.pictureId, '14');
//           expect(result.restaurant.categories, isA<List<Category>>());
//           expect(result.restaurant.menus, isA<Menus>());
//           expect(result.restaurant.rating, 4.2);
//           expect(
//               result.restaurant.customerReviews, isA<List<CustomerReview>>());
//         } else {
//           throw Exception('Failed to load restaurant detail');
//         }
//       });
//     });

//     group('Get Restaurant Search', () {
//       test('Should be able to parse restaurantSearchFromJson from json',
//           () async {
//         final response = await http.get(
//             Uri.parse('https://restaurant-api.dicoding.dev/search?q=kafe'));

//         if (response.statusCode == 200) {
//           RestaurantSearch result = restaurantSearchFromJson(response.body);
//           expect(result.error, false);
//           expect(result.founded, 4);
//           expect(result.restaurants.length, 4);
//           expect(result.restaurants[0].id, 's1knt6za9kkfw1e867');
//           expect(result.restaurants[0].name, 'Kafe Kita');
//           expect(result.restaurants[0].description, isA<String>());
//           expect(result.restaurants[0].pictureId, '25');
//           expect(result.restaurants[0].city, 'Gorontalo');
//           expect(result.restaurants[0].rating, 4);
//         } else {
//           throw Exception('Failed to load restaurant search');
//         }
//       });
//     });
//   });
// }
