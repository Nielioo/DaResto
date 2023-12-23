part of 'providers.dart';

class GetRestaurantDetailProvider extends ChangeNotifier {
  final RestaurantApiService restaurantApiService;
  final String id;

  GetRestaurantDetailProvider({required this.restaurantApiService, required this.id}) {
    fetchRestaurantDetail(id);
  }

  late GetRestaurantDetail _restaurantDetail;
  late DataState _state;
  String _message = '';

  String get message => _message;

  GetRestaurantDetail get result => _restaurantDetail;

  DataState get state => _state;

  Future<dynamic> fetchRestaurantDetail(id) async {
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