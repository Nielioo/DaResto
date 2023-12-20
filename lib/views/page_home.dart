part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
        title: Text('HomePage'),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return RestaurantCard(
            imageUrl: restaurants[index].pictureId,
            restaurantName: restaurants[index].name,
            location: restaurants[index].city,
            rating: restaurants[index].rating.toString(),
          );
        },
      ),
    );
  }
}
