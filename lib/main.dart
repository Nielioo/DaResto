import 'package:http/http.dart' as http;

import 'package:daresto/providers/providers.dart';
import 'package:daresto/services/services.dart';
import 'package:daresto/views/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final restaurantService = RestaurantApiService(client: http.Client());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GetRestaurantListProvider(
            restaurantApiService: restaurantService,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => GetRestaurantDetailProvider(
            restaurantApiService: restaurantService,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantSearchProvider(
            restaurantApiService: restaurantService,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CustomerReviewProvider(
            restaurantApiService: restaurantService,
          ),
        ),
      ],
      child: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
            title: 'DaResto',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            initialRoute: SplashPage.routeName,
            routes: {
              SplashPage.routeName: (context) => const SplashPage(),
              HomePage.routeName: (context) => const HomePage(),
              RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                  id: ModalRoute.of(context)?.settings.arguments as String),
              AddReviewPage.routeName: (context) => AddReviewPage(id: ModalRoute.of(context)?.settings.arguments as String),
            }),
      ),
    );
  }
}
