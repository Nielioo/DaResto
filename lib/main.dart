import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:daresto/shared/shared.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:daresto/providers/providers.dart';
import 'package:daresto/services/services.dart';
import 'package:daresto/views/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    
Future<void> main() async {
  await Hive.initFlutter();
  await HiveHelper.init();
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService backgroundService = BackgroundService();
  backgroundService.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

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
          create: (_) => FavoriteRestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
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
        onTap: () {
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
              RestaurantListPage.routeName: (context) => const RestaurantListPage(),
              RestaurantFavoritePage.routeName: (context) => const RestaurantFavoritePage(),
              SettingsPage.routeName: (context) => const SettingsPage(),
              RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                    id: ModalRoute.of(context)?.settings.arguments as String,
                  ),
              AddReviewPage.routeName: (context) => AddReviewPage(
                    id: ModalRoute.of(context)?.settings.arguments as String,
                  ),
            }),
      ),
    );
  }
}
