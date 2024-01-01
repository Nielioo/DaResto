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
                    child: Consumer<RestaurantSearchProvider>(
                      builder: (context, state, _) {
                        if (state.state == DataState.loading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: violet500,
                            ),
                          );
                        } else if (state.state == DataState.hasData) {
                          final restaurants = state.result?.restaurants ?? [];

                          return RestaurantListView(restaurants: restaurants);
                        } else if (state.state == DataState.noData) {
                          return SearchWarning(
                            text:
                                'Restaurant named "${watchSearch.searchController.text} not found!"',
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
                  )
                : Expanded(
                    child: Consumer<GetRestaurantListProvider>(
                      builder: (context, state, _) {
                        if (state.state == DataState.loading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: violet500,
                            ),
                          );
                        } else if (state.state == DataState.hasData) {
                          final restaurants = state.result!.restaurants;

                          return RestaurantListView(restaurants: restaurants);
                        } else if (state.state == DataState.noData) {
                          return const Center(
                            child: Text("There is no registered restaurant!"),
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
