part of 'providers.dart';

class CustomerReviewProvider extends ChangeNotifier {
  final RestaurantApiService restaurantApiService;

  CustomerReviewProvider({required this.restaurantApiService});

  CustomerReview? _customerReview;
  CustomerReview? get result => _customerReview;

  DataState? _state;
  DataState? get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> postCustomerReview(CustomerReview data) async {
    try {
      _state = DataState.loading;
      notifyListeners();
      final response = await restaurantApiService.postCustomerReview(data);
      if (response.review.isEmpty) {
        _state = DataState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = DataState.hasData;
        notifyListeners();
        return _customerReview = response;
      }
    } catch (e) {
      _state = DataState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
