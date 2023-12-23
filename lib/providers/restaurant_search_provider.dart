part of 'providers.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final RestaurantApiService restaurantApiService;
  final String query;

  RestaurantSearchProvider({required this.restaurantApiService, required this.query}) {
    fetchRestaurantSearchResult();
  }

  late RestaurantSearch _restaurantSearchResult;
  late DataState _state;
  String _message = '';

  String get message => _message;

  RestaurantSearch get result => _restaurantSearchResult;

  DataState get state => _state;

  Future<dynamic> fetchRestaurantSearchResult() async {
    try {
      _state = DataState.loading;
      notifyListeners();
      final response = await restaurantApiService.getRestaurantSearch(query);
      if (response.restaurants.isEmpty) {
        _state = DataState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = DataState.hasData;
        notifyListeners();
        return _restaurantSearchResult = response;
      }
    } catch (e) {
      _state = DataState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}