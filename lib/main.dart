import 'package:http/http.dart' as http;

import 'package:daresto/providers/providers.dart';
import 'package:daresto/services/services.dart';
import 'package:daresto/views/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GetRestaurantListProvider(
            restaurantApiService: RestaurantApiService(client: http.Client()),
          ),
        ),
      ],
      child: MaterialApp(
          title: 'DaResto',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: HomePage.routeName,
          routes: {
            HomePage.routeName: (context) => const HomePage(),
            RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(id: ModalRoute.of(context)?.settings.arguments as String),
          }),
    );
  }
}
