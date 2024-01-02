part of 'pages.dart';

class RestaurantFavoritePage extends StatelessWidget {
  static const String routeName = '/restaurant-favorite';

  const RestaurantFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen variable changes, best for calling variable
    final watchFavorite = context.watch<FavoriteRestaurantProvider>();

    // Only read variable, not for listen changes, best for calling function
    final readFavorite = context.read<FavoriteRestaurantProvider>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Gap.h24,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                controller: watchFavorite.searchController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                  hintText: "Search Favorite Restaurant",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
                onChanged: (value) {
                  readFavorite.searchedFavoriteRestaurants.value =
                      readFavorite.getFavoriteRestaurantByQuery(value);
                },
              ),
            ),
            watchFavorite.searchController.text.isNotEmpty
                ? Expanded(
                    child: ValueListenableBuilder<List<RestaurantList>>(
                      valueListenable:
                          watchFavorite.searchedFavoriteRestaurants,
                      builder: (context, restaurants, _) {
                        return RestaurantListView(restaurants: restaurants);
                      },
                    ),
                  )
                : Expanded(
                    child: Consumer<FavoriteRestaurantProvider>(
                      builder: (context, provider, _) {
                        final favoriteRestaurants =
                            provider.getAllFavoriteRestaurant();
                        if (favoriteRestaurants.isNotEmpty) {
                          return RestaurantListView(
                              restaurants: favoriteRestaurants);
                        } else {
                          return const SearchWarning(
                            text: 'You don\'t have any favorite restaurant yet',
                          );
                        }
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
