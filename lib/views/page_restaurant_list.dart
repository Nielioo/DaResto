part of 'pages.dart';

class RestaurantListPage extends StatelessWidget {
  static const String routeName = '/restaurant-list';

  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen variable changes, best for calling variable
    final watchSearch = context.watch<RestaurantSearchProvider>();

    // Only read variable, not for listen changes, best for calling function
    final readList = context.read<GetRestaurantListProvider>();
    final readSearch = context.read<RestaurantSearchProvider>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Gap.h24,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                controller: watchSearch.searchController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 4.0),
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
            ),
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
                                  Gap.h4,
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
                                        pictureId: restaurants[index].pictureId,
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
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                        "There is an error while load data!"),
                                    Gap.h12,
                                    ElevatedButton(
                                      onPressed: () {
                                        readList.fetchRestaurantList();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: const Text('Refresh Data'),
                                    )
                                  ],
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
                                  pictureId: restaurants[index].pictureId,
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
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("There is an error while load data!"),
                              Gap.h12,
                              ElevatedButton(
                                onPressed: () {
                                  readList.fetchRestaurantList();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text('Refresh Data'),
                              )
                            ],
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
