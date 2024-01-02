part of 'pages.dart';

class RestaurantFavoritePage extends StatelessWidget {
  static const String routeName = '/restaurant-favorite';

  const RestaurantFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Gap.h24,
            Expanded(child: Consumer<DatabaseProvider>(
              builder: (context, databaseProvider, _) {
                final favoriteRestaurants =
                    databaseProvider.getAllFavoriteRestaurant();
                return RestaurantListView(restaurants: favoriteRestaurants);
              },
            )),
          ],
        ),
      ),
    );
  }
}
