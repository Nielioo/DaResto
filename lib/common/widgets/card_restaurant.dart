part of 'widgets.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantList restaurant;

  const RestaurantCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    // Listen variable changes, best for calling variable
    final watchFavorite = context.watch<FavoriteRestaurantProvider>();

    // Only read variable, not for listen changes, best for calling function
    final readFavorite = context.read<FavoriteRestaurantProvider>();

    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Hero(
                tag: 'restaurantImage${restaurant.pictureId}',
                child: Image.network(
                  '${Const.baseUrl}/images/large/${restaurant.pictureId}',
                  width: Size.screenWidth(context) * 0.3,
                  height: Size.screenHeight(context) * 0.1,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Gap.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: Style.headline3.copyWith(fontWeight: FontWeight.bold),
                ),
                Gap.h4,
                Row(
                  children: [
                    const Icon(Icons.location_pin, size: 16),
                    Gap.w4,
                    Text(restaurant.city, style: Style.text2,),
                  ],
                ),
                Gap.h4,
                Row(
                  children: [
                    const Icon(Icons.stars_rounded, size: 16),
                    Gap.w4,
                    Text(restaurant.rating.toString(), style: Style.text2,),
                  ],
                ),
              ],
            ),
          ),
          Consumer<FavoriteRestaurantProvider>(
            builder: (context, state, _) {
              return IconButton(
                icon: Icon(
                  watchFavorite.isFavoriteRestaurantExist(
                          restaurantId: restaurant.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () async {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  if (watchFavorite.isFavoriteRestaurantExist(
                      restaurantId: restaurant.id)) {
                    readFavorite.deleteFavoriteRestaurant(
                        restaurantId: restaurant.id);
                    const snackBar = SnackBar(
                      content: Text('Removed from favorite'),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    readFavorite.saveFavoriteRestaurant(restaurant: restaurant);
                    const snackBar = SnackBar(
                      content: Text('Added to favorite'),
                      backgroundColor: violet500,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              );
            },
          ),
          Gap.w4,
        ],
      ),
    );
  }
}
