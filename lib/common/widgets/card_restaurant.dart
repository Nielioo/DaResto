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
    final watchDatabase = context.watch<DatabaseProvider>();

    // Only read variable, not for listen changes, best for calling function
    final readDatabase = context.read<DatabaseProvider>();

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
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.1,
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
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.map, size: 12),
                    Gap.w4,
                    Text(restaurant.city),
                  ],
                ),
                Row(
                  children: [
                    const Icon(FontAwesomeIcons.star, size: 12),
                    Gap.w4,
                    Text(restaurant.rating.toString()),
                  ],
                ),
              ],
            ),
          ),
          Consumer<DatabaseProvider>(
            builder: (context, state, _) {
              return IconButton(
                icon: Icon(
                  watchDatabase.isFavoriteRestaurantExist(
                          restaurantId: restaurant.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () async {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  if (watchDatabase.isFavoriteRestaurantExist(
                      restaurantId: restaurant.id)) {
                    readDatabase.deleteFavoriteRestaurant(
                        restaurantId: restaurant.id);
                    const snackBar = SnackBar(
                      content: Text('Removed from favorite'),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    readDatabase.saveFavoriteRestaurant(restaurant: restaurant);
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
