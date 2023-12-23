part of 'services.dart';

class RestaurantApiService {

  Future<GetRestaurantList> getRestaurantList() async {
    var response = await http.get(Uri.parse('${Const.baseUrl}/list'));
    if (response.statusCode == 200) {
      return GetRestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get restaurant list');
    }
  }

  Future<GetRestaurantDetail> getRestaurantDetail(id) async {
    var response = await http.get(Uri.parse('${Const.baseUrl}/detail/$id'));
    if (response.statusCode == 200) {
      return GetRestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get restaurant detail');
    }
  }

  Future<RestaurantSearch> getRestaurantSearch(query) async {
    var response = await http.get(Uri.parse('${Const.baseUrl}/search?q=$query'));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get restaurant data');
    }
  }
}