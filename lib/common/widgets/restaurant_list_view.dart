part of 'widgets.dart';

class RestaurantListView extends StatelessWidget {
  final List<RestaurantList> restaurants;

  const RestaurantListView({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              RestaurantDetailPage.routeName,
              arguments:
                  restaurants[index].id, // Pass the restaurant to detail page
            );
          },
          child: RestaurantCard(
            pictureId: restaurants[index].pictureId,
            restaurantName: restaurants[index].name,
            location: restaurants[index].city,
            rating: restaurants[index].rating.toString(),
          ),
        );
      },
    );
  }
}
