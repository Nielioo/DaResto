import 'package:daresto/models/models.dart';
import 'package:daresto/services/services.dart';
import 'package:daresto/shared/shared.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('RestaurantApiService', () {
    late http.Client client;
    late RestaurantApiService apiService;

    setUp(() {
      client = MockClient();
      apiService = RestaurantApiService(client: client);
    });

    group('getRestaurantList', () {
      test('returns restaurant list if the http call completes successfully',
          () async {
        const jsonString = '{"error":false,"message":'
            '"success","count":20,"restaurants":[]}';
        final uri = Uri.parse('${Const.baseUrl}/list');
        when(() => client.get(uri))
            .thenAnswer((_) async => http.Response(jsonString, 200));

        expect(await apiService.getRestaurantList(), isA<GetRestaurantList>());
      });

      test('throws an exception if the http call completes with an error',
          () async {
        final uri = Uri.parse('${Const.baseUrl}/list');
        when(() => client.get(uri))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(apiService.getRestaurantList(), throwsException);
      });
    });

    group('getRestaurantDetail', () {
      test('returns restaurant detail if the http call completes successfully',
          () async {
        const jsonString = '{"error":false,"message":"success","restaurant":'
            '{"id":"rqdv5juczeskfw1e867","name":"Test Restaurant",'
            '"description":"Test Description","city":"Test City",'
            '"address":"Test Address","pictureId":"Test Picture",'
            '"categories":[],"menus":{"foods":[],"drinks":[]},'
            '"rating":4.2,"customerReviews":[]}}';
        const id = 'rqdv5juczeskfw1e867';
        final uri = Uri.parse('${Const.baseUrl}/detail/$id');
        when(() => client.get(uri))
            .thenAnswer((_) async => http.Response(jsonString, 200));

        expect(await apiService.getRestaurantDetail(id),
            isA<GetRestaurantDetail>());
      });

      test('throws an exception if the http call completes with an error',
          () async {
        const id = 'rqdv5juczeskfw1e867';
        final uri = Uri.parse('${Const.baseUrl}/detail/$id');
        when(() => client.get(uri))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(apiService.getRestaurantDetail(id), throwsException);
      });
    });

    group('getRestaurantSearch', () {
      test(
          'returns restaurant search results if the http call completes successfully',
          () async {
        const jsonString =
            '{"error":false,"founded":20,"restaurants":[]}';
        const query = 'Test Restaurant';
        final uri = Uri.parse('${Const.baseUrl}/search?q=$query');
        when(() => client.get(uri))
            .thenAnswer((_) async => http.Response(jsonString, 200));

        expect(await apiService.getRestaurantSearch(query),
            isA<RestaurantSearch>());
      });

      test('throws an exception if the http call completes with an error',
          () async {
        const query = 'Test Restaurant';
        final uri = Uri.parse('${Const.baseUrl}/search?q=$query');
        when(() => client.get(uri))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(apiService.getRestaurantSearch(query), throwsException);
      });
    });
  });
}
