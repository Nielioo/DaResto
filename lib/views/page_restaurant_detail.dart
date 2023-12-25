part of 'pages.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const String routeName = '/restaurant-detail';

  final String id;

  const RestaurantDetailPage({super.key, required this.id});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    // Called `fetchRestaurantDetail()` after `build()` already executed when RestaurantDetailPage is opened
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<GetRestaurantDetailProvider>()
          .fetchRestaurantDetail(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Detail'),
      ),
      body: SingleChildScrollView(
        child: Consumer<GetRestaurantDetailProvider>(
            builder: (context, state, _) {
              if (state.state == DataState.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurple,
                  ),
                );
              } else if (state.state == DataState.hasData) {
                var restaurant = state.result!.restaurant;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'restaurantImage${restaurant.pictureId}',
                      child: Image.network(
                          '${Const.baseUrl}/images/large/${restaurant.pictureId}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.name,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                FontAwesomeIcons.map,
                                size: MediaQuery.of(context).size.height * 0.02,
                              ),
                              const SizedBox(width: 8),
                              Text(restaurant.city),
                              const SizedBox(width: 12),
                              Icon(
                                FontAwesomeIcons.star,
                                size: MediaQuery.of(context).size.height * 0.02,
                              ),
                              const SizedBox(width: 8),
                              Text(restaurant.rating.toString()),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            restaurant.description,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Foods',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: restaurant.menus.foods.length,
                              itemBuilder: (context, index) {
                                return MenuCard(
                                    imagePath: 'assets/food_dummy.jpg',
                                    title: restaurant.menus.foods[index].name);
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Drinks',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: restaurant.menus.drinks.length,
                              itemBuilder: (context, index) {
                                return MenuCard(
                                    imagePath: 'assets/drink_dummy.png',
                                    title: restaurant.menus.drinks[index].name);
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Review',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: restaurant.menus.drinks.length,
                              itemBuilder: (context, index) {
                                return MenuCard(
                                    imagePath: 'assets/drink_dummy.png',
                                    title: restaurant.menus.drinks[index].name);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state.state == DataState.noData) {
                return const Center(
                  child: Text("No Data Found!"),
                );
              } else if (state.state == DataState.error) {
                return const Center(
                  child: Text("There is an error while load data!"),
                );
              } else {
                return const Center(
                  child: Text("Failed to Load Data!"),
                );
              }
            },
          ),
      ),
    );
  }
}
