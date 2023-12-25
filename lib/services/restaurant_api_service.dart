part of 'services.dart';

class RestaurantApiService {
  http.Client client;
  RestaurantApiService({required this.client});

  Future<GetRestaurantList> getRestaurantList() async {
    var response = await client.get(Uri.parse('${Const.baseUrl}/list'));
    if (response.statusCode == 200) {
      return GetRestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get restaurant list');
    }
  }

  Future<GetRestaurantDetail> getRestaurantDetail(id) async {
    var response = await client.get(Uri.parse('${Const.baseUrl}/detail/$id'));
    if (response.statusCode == 200) {
      return GetRestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get restaurant detail');
    }
  }

  Future<RestaurantSearch> getRestaurantSearch(query) async {
    var response =
        await client.get(Uri.parse('${Const.baseUrl}/search?q=$query'));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get restaurant data');
    }
  }

  Future<CustomerReview> postCustomerReview(
      String id, String name, String review) async {
    var response = await client.post(
      Uri.parse('${Const.baseUrl}/review'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'id': id,
          'name': name,
          'review': review,
        },
      ),
    );
    if (response.statusCode == 200) {
      return CustomerReview.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post customer review');
    }
  }
}
