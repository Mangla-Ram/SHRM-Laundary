import 'package:flutter/material.dart';
import 'package:shrm/screens/rautes.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/service_detail_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/offers_screen.dart';
import 'screens/about_screen.dart';
import 'screens/profile_screen.dart';
import 'routes.dart';

void main() {
  runApp(SHRMApp());
}

class SHRMApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SHRM Laundry App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
        '/orders': (context) => OrdersScreen(),
        '/offers': (context) => OffersScreen(),
        '/about': (context) => AboutScreen(),
        '/profile': (context) => ProfileScreen(),
        Routes.laundry: (context) => ServiceDetailScreen(serviceType: ServiceType.laundry),
        Routes.shoeCleaning: (context) => ServiceDetailScreen(serviceType: ServiceType.shoeCleaning),
        Routes.steamPress: (context) => ServiceDetailScreen(serviceType: ServiceType.steamPress),
        Routes.dryCleaning: (context) => ServiceDetailScreen(serviceType: ServiceType.dryCleaning),
      },
    );
  }
}
