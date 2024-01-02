part of 'pages.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bottomNavIndex == 0
          ? const RestaurantListPage()
          : _bottomNavIndex == 1
              ? RestaurantFavoritePage()
              : const SettingsPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        selectedItemColor: violet500,
        onTap: (value) {
          setState(() {
            _bottomNavIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'List',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
