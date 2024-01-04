part of 'pages.dart';

class RestaurantFavoritePage extends StatefulWidget {
  static const String routeName = '/restaurant-favorite';
  const RestaurantFavoritePage({super.key});

  @override
  State<RestaurantFavoritePage> createState() => _RestaurantFavoritePageState();
}

class _RestaurantFavoritePageState extends State<RestaurantFavoritePage> {
  // Listen variable changes, best for calling variable
  FavoriteRestaurantProvider get watchFavorite =>
      context.watch<FavoriteRestaurantProvider>();

  // Only read variable, not for listen changes, best for calling function
  FavoriteRestaurantProvider get readFavorite =>
      context.read<FavoriteRestaurantProvider>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      readFavorite.getAllFavoriteRestaurant();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  readFavorite.getFavoriteRestaurantByQuery(value);
                },
              ),
            ),
            watchFavorite.searchController.text.isNotEmpty
                ? Expanded(
                    child: Builder(
                      builder: (context) {
                        if (watchFavorite
                            .searchedFavoriteRestaurants.isNotEmpty) {
                          return RestaurantListView(
                              restaurants:
                                  watchFavorite.searchedFavoriteRestaurants);
                        } else {
                          return SearchWarning(
                            text:
                                'You don\'t have any favorite restaurant named "${watchFavorite.searchController.text}"',
                          );
                        }
                      },
                    ),
                  )
                : Expanded(
                    child: Consumer<FavoriteRestaurantProvider>(
                      builder: (context, provider, _) {
                        if (watchFavorite.restaurantFavoriteList.isNotEmpty) {
                          return RestaurantListView(
                              restaurants:
                                  watchFavorite.restaurantFavoriteList);
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
