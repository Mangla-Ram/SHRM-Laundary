import 'package:flutter/material.dart';
import 'service_detail_screen.dart';

class Routes {
  static const String laundry = '/laundry';
  static const String shoeCleaning = '/shoe-cleaning';
  static const String steamPress = '/steam-press';
  static const String dryCleaning = '/dry-cleaning';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      laundry: (context) => ServiceDetailScreen(serviceType: ServiceType.laundry),
      shoeCleaning: (context) => ServiceDetailScreen(serviceType: ServiceType.shoeCleaning),
      steamPress: (context) => ServiceDetailScreen(serviceType: ServiceType.steamPress),
      dryCleaning: (context) => ServiceDetailScreen(serviceType: ServiceType.dryCleaning),
    };
  }
}