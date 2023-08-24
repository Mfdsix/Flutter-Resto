import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_restaurant/data/api/api_service.dart';
import 'package:flutter_restaurant/data/db/database_helper.dart';
import 'package:flutter_restaurant/data/preferences/notification_preference.dart';
import 'package:flutter_restaurant/provider/api/get_all_restaurant_provider.dart';
import 'package:flutter_restaurant/provider/database_provider.dart';
import 'package:flutter_restaurant/provider/home_tab_provider.dart';
import 'package:flutter_restaurant/provider/notification_preference_provider.dart';
import 'package:flutter_restaurant/provider/scheduling_provider.dart';
import 'package:flutter_restaurant/ui/restaurant_detail_page.dart';
import 'package:flutter_restaurant/ui/home_page.dart';
import 'package:flutter_restaurant/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/ui/restaurant_search_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => HomeTabProvider()),
          ChangeNotifierProvider(
              create: (_) =>
                  GetAllRestaurantProvider(apiService: ApiService())),
          ChangeNotifierProvider(create: (_) => SchedulingProvider()),
          ChangeNotifierProvider(
              create: (_) => NotificationPreferenceProvider(
                  notificationPreference: NotificationPreference(
                      sharedPreferences: SharedPreferences.getInstance()))),
          ChangeNotifierProvider(
              create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
        ],
        child: MaterialApp(
          title: 'Puth Food',
          theme: ThemeData(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: primaryColor,
                  onPrimary: Colors.black,
                  secondary: secondaryColor,
                ),
            scaffoldBackgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: myTextTheme,
            appBarTheme: const AppBarTheme(elevation: 0),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
              ),
            ),
          ),
          initialRoute: HomePage.routeName,
          routes: {
            HomePage.routeName: (context) => const HomePage(),
            RestaurantSearchPage.routeName: (context) =>
                const RestaurantSearchPage(),
            RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                restaurantId:
                    ModalRoute.of(context)?.settings.arguments as String),
          },
        ));
  }
}
