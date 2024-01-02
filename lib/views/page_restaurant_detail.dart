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
                        Gap.h4,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              FontAwesomeIcons.map,
                              size: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Gap.w4,
                            Text(restaurant.city),
                            Gap.w12,
                            Icon(
                              FontAwesomeIcons.star,
                              size: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Gap.w4,
                            Text(restaurant.rating.toString()),
                          ],
                        ),
                        Gap.h12,
                        Text(
                          restaurant.description,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Gap.h12,
                        Text(
                          'Foods',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Gap.h4,
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.20,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurant.menus.foods.length,
                            itemBuilder: (context, index) {
                              return MenuCard(
                                  imagePath: 'assets/images/food_dummy.png',
                                  title: restaurant.menus.foods[index].name);
                            },
                          ),
                        ),
                        Gap.h12,
                        Text(
                          'Drinks',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Gap.h4,
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.20,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurant.menus.drinks.length,
                            itemBuilder: (context, index) {
                              return MenuCard(
                                  imagePath: 'assets/images/drink_dummy.png',
                                  title: restaurant.menus.drinks[index].name);
                            },
                          ),
                        ),
                        Gap.h12,
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Review',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_rounded),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AddReviewPage.routeName,
                                  arguments: restaurant.id,
                                ).then(
                                  (result) {
                                    if (result != null && result == true) {
                                      Provider.of<GetRestaurantDetailProvider>(
                                              context,
                                              listen: false)
                                          .fetchRestaurantDetail(widget.id);
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        Gap.h4,
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: restaurant.customerReviews.length,
                            itemBuilder: (context, index) {
                              return CustomerReviewCard(
                                  name: restaurant.customerReviews[index].name,
                                  review:
                                      restaurant.customerReviews[index].review,
                                  date: restaurant.customerReviews[index].date);
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
