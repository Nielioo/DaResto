part of 'pages.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RestaurantList> restaurants = [];
  List<RestaurantList> filteredRestaurants = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchRestaurants();
  }

  void fetchRestaurants() async {
    var restaurantListProvider = GetRestaurantListProvider(
      restaurantApiService: RestaurantApiService(client: http.Client()),
    );
    await restaurantListProvider.fetchRestaurantList();
    setState(() {
      restaurants = restaurantListProvider.result.restaurants;
      filteredRestaurants = restaurants;
    });
  }

  void searchRestaurants(String query) {
    List<RestaurantList> tempRestaurants = [];
    tempRestaurants.addAll(restaurants);

    if (query.isNotEmpty) {
      tempRestaurants.retainWhere((restaurant) {
        String searchTerm = query.toLowerCase();
        String restaurantName = restaurant.name.toLowerCase();
        return restaurantName.contains(searchTerm);
      });
    }
    setState(() {
      filteredRestaurants = tempRestaurants;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant List'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 12.0),
        child: Column(
          children: [
            const SizedBox(height: 12),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                hintText: "Search Restaurant",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
              onChanged: (value) {
                searchRestaurants(value);
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: filteredRestaurants.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.warning_amber_rounded,
                              size: 72,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'There is no restaurant named "${_searchController.text}"',
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: Consumer<GetRestaurantListProvider>(
                          builder: (context, state, _) {
                        if (state.state == DataState.loading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.deepPurple,
                            ),
                          );
                        } else if (state.state == DataState.hasData) {
                          var restaurants = filteredRestaurants;
                          return ListView.builder(
                            itemCount: restaurants.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RestaurantDetailPage.routeName,
                                    arguments: restaurants[index]
                                        .id, // Pass the restaurant to detail page
                                  );
                                },
                                child: RestaurantCard(
                                  imageUrl:
                                      '${Const.baseUrl}/images/small/${restaurants[index].pictureId}',
                                  restaurantName: restaurants[index].name,
                                  location: restaurants[index].city,
                                  rating: restaurants[index].rating.toString(),
                                ),
                              );
                            },
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
                      }),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
