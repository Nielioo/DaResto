part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RestaurantElement> restaurants = [];

  @override
  void initState() {
    super.initState();
    readJson().then((data) {
      setState(() {
        restaurants = data.restaurants;
      });
    });
  }

  Future<Restaurant> readJson() async {
    final String response =
        await rootBundle.loadString('assets/local_restaurant.json');
    final data = await json.decode(response);
    // print('Data: $data');
    return Restaurant.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RestaurantDetailPage.routeName,
                  arguments: restaurants[index], // Pass the restaurant to detail page
                );
              },
              child: RestaurantCard(
                imageUrl: restaurants[index].pictureId,
                restaurantName: restaurants[index].name,
                location: restaurants[index].city,
                rating: restaurants[index].rating.toString(),
              ),
            );
          },
        ),
      ),
    );
  }
}
