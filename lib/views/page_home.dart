part of 'pages.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<RestaurantElement> restaurants = [];
  // List<RestaurantElement> filteredRestaurants = [];
  // final TextEditingController searchController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   readJson().then((data) {
  //     setState(() {
  //       restaurants = data.restaurants;
  //       filteredRestaurants = List.from(restaurants);
  //     });
  //   });
  // }

  // Future<Restaurant> readJson() async {
  //   final String response =
  //       await rootBundle.loadString('assets/local_restaurant.json');
  //   final data = await json.decode(response);
  //   return Restaurant.fromJson(data);
  // }

  // void filterRestaurants() {
  //   List<RestaurantElement> tempRestaurants = [];
  //   tempRestaurants.addAll(restaurants);
  //   if (searchController.text.isNotEmpty) {
  //     tempRestaurants.retainWhere((restaurant) {
  //       String searchTerm = searchController.text.toLowerCase();
  //       String restaurantName = restaurant.name.toLowerCase();
  //       return restaurantName.contains(searchTerm);
  //     });
  //   }
  //   setState(() {
  //     filteredRestaurants = tempRestaurants;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
            //   child: TextField(
            //     controller: searchController,
            //     decoration: const InputDecoration(
            //       contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            //       hintText: "Search Restaurant",
            //       prefixIcon: Icon(Icons.search),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(12.0),
            //         ),
            //       ),
            //     ),
            //     onChanged: (value) {
            //       filterRestaurants();
            //     },
            //   ),
            // ),

            // Expanded(
            //   child: filteredRestaurants.isEmpty
            //       ? Center(
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 const Icon(
            //                   Icons.warning_amber_rounded,
            //                   size: 72,
            //                 ),
            //                 const SizedBox(height: 4),
            //                 Text(
            //                   'There is no restaurant named "${searchController.text}"',
            //                   style: const TextStyle(fontSize: 16),
            //                   textAlign: TextAlign.center,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         )
            //       : ListView.builder(
            //           itemCount: filteredRestaurants.length,
            //           itemBuilder: (context, index) {
            //             return GestureDetector(
            //               onTap: () {
            //                 Navigator.pushNamed(
            //                   context,
            //                   RestaurantDetailPage.routeName,
            //                   arguments: filteredRestaurants[
            //                       index], // Pass the restaurant to detail page
            //                 );
            //               },
            //               child: RestaurantCard(
            //                 imageUrl: filteredRestaurants[index].pictureId,
            //                 restaurantName: filteredRestaurants[index].name,
            //                 location: filteredRestaurants[index].city,
            //                 rating:
            //                     filteredRestaurants[index].rating.toString(),
            //               ),
            //             );
            //           },
            //         ),
            // ),

            Expanded(
              child: Consumer<GetRestaurantListProvider>(
                  builder: (context, state, _) {
                if (state.state == DataState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple,
                    ),
                  );
                } else if (state.state == DataState.hasData) {
                  var restaurants = state.result.restaurants;
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
                          rating:
                              restaurants[index].rating.toString(),
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
          ],
        ),
      ),
    );
  }
}
