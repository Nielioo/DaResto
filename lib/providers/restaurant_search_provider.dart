part of 'providers.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final RestaurantApiService restaurantApiService;

  RestaurantSearchProvider({required this.restaurantApiService});

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  RestaurantSearch? _restaurantSearchResult;
  RestaurantSearch? get result => _restaurantSearchResult;

  DataState? _state;
  DataState? get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> fetchRestaurantSearchResult(String query) async {
    try {
      _state = DataState.loading;
      notifyListeners();
      final response = await restaurantApiService.getRestaurantSearch(query);
      if (response.restaurants.isEmpty) {
        _state = DataState.noData;
        _message = 'Empty Data';
        notifyListeners();
      } else {
        _state = DataState.hasData;
        _restaurantSearchResult = response;
        notifyListeners();
      }
    } catch (e) {
      _state = DataState.error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }
}
