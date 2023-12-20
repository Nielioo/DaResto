part of 'pages.dart';

class RestaurantDetailPage extends StatefulWidget {
  const RestaurantDetailPage({super.key});

  static const String routeName = '/restaurant-detail';

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  Widget build(BuildContext context) {
    final RestaurantElement? restaurant =
        ModalRoute.of(context)?.settings.arguments as RestaurantElement?;

    // Check if restaurant is null
    if (restaurant == null) {
      return const Scaffold(
        body: Center(child: Text('No restaurant data found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${restaurant.name}\'s Detail'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(restaurant.pictureId),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      restaurant.name,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.map,
                          size: MediaQuery.of(context).size.height * 0.02,
                        ),
                        const SizedBox(width: 8),
                        Text(restaurant.city),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(restaurant.description, style: Theme.of(context).textTheme.labelSmall,),
                    const SizedBox(height: 12),
                    Text(
                      'Foods',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurant.menus.foods.length,
                        itemBuilder: (context, index) {
                          return MenuCard(imagePath: 'assets/food_dummy.jpg', title: restaurant.menus.foods[index].name);
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Drinks',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurant.menus.foods.length,
                        itemBuilder: (context, index) {
                          return MenuCard(imagePath: 'assets/drink_dummy.png', title: restaurant.menus.drinks[index].name);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
