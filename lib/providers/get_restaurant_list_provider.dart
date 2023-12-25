part of 'providers.dart';

class GetRestaurantListProvider extends ChangeNotifier {
  final RestaurantApiService restaurantApiService;

  GetRestaurantListProvider({required this.restaurantApiService}) {
    fetchRestaurantList();
  }

  GetRestaurantList? _restaurantList;
  GetRestaurantList? get result => _restaurantList;

  DataState? _state;
  DataState? get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> fetchRestaurantList() async {
    try {
      _state = DataState.loading;
      notifyListeners();
      final response = await restaurantApiService.getRestaurantList();
      if (response.restaurants.isEmpty) {
        _state = DataState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = DataState.hasData;
        notifyListeners();
        return _restaurantList = response;
      }
    } catch (e) {
      _state = DataState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
