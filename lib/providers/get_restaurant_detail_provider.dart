part of 'providers.dart';

class GetRestaurantDetailProvider extends ChangeNotifier {
  final RestaurantApiService restaurantApiService;

  GetRestaurantDetailProvider({required this.restaurantApiService});

  GetRestaurantDetail? _restaurantDetail;
  GetRestaurantDetail? get result => _restaurantDetail;

  DataState? _state;
  DataState? get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> fetchRestaurantDetail(String id) async {
    try {
      _state = DataState.loading;
      notifyListeners();
      final response = await restaurantApiService.getRestaurantDetail(id);
      if (response.error) {
        _state = DataState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = DataState.hasData;
        notifyListeners();
        return _restaurantDetail = response;
      }
    } catch (e) {
      _state = DataState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
