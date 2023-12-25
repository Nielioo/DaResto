part of 'pages.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen variable changes, best for calling variable
    final watchSearch = context.watch<RestaurantSearchProvider>();

    // Only read variable, not for listen changes, best for calling function
    final readSearch = context.read<RestaurantSearchProvider>();

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
            DaSpacer.vertical(space: Space.medium),
            TextField(
              controller: watchSearch.searchController,
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
                readSearch.fetchRestaurantSearchResult(value);
              },
            ),
            DaSpacer.vertical(space: Space.medium),
            watchSearch.searchController.text.isNotEmpty
                ? Expanded(
                    child: watchSearch.result?.restaurants.isEmpty ?? true
                        ? Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.warning_amber_rounded,
                                    size: 72,
                                  ),
                                  DaSpacer.vertical(space: Space.tiny),
                                  Text(
                                    'There is no restaurant named "${watchSearch.searchController.text}"',
                                    style: const TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Consumer<RestaurantSearchProvider>(
                            builder: (context, state, _) {
                              if (state.state == DataState.loading) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.deepPurple,
                                  ),
                                );
                              } else if (state.state == DataState.hasData) {
                                final restaurants =
                                    state.result?.restaurants ?? [];

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
                                        rating: restaurants[index]
                                            .rating
                                            .toString(),
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
                                  child: Text(
                                      "There is an error while load data!"),
                                );
                              } else {
                                return const Center(
                                  child: Text("Failed to Load Data!"),
                                );
                              }
                            },
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
                          final restaurants = state.result!.restaurants;

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
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
