part of 'providers.dart';

class GetRestaurantListProvider extends ChangeNotifier {
  final RestaurantApiService restaurantApiService;

  GetRestaurantListProvider({required this.restaurantApiService}) {
    fetchRestaurantList();
  }

  late GetRestaurantList _restaurantList;
  late DataState _state;
  String _message = '';

  String get message => _message;

  GetRestaurantList get result => _restaurantList;

  DataState get state => _state;

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
      print(e);
      return _message = 'Error --> $e';
    }
  }
}
