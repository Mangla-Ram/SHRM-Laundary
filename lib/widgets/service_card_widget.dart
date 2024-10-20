import 'package:flutter/material.dart';
import 'package:shrm/screens/service_detail_screen.dart';
import '../screens/rautes.dart';
import 'routes.dart';

class ServiceCardWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final ServiceType serviceType;

  ServiceCardWidget({
    required this.title,
    required this.imagePath,
    required this.serviceType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToServiceDetail(context),
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 80),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToServiceDetail(BuildContext context) {
    switch (serviceType) {
      case ServiceType.laundry:
        Navigator.pushNamed(context, Routes.laundry);
        break;
      case ServiceType.shoeCleaning:
        Navigator.pushNamed(context, Routes.shoeCleaning);
        break;
      case ServiceType.steamPress:
        Navigator.pushNamed(context, Routes.steamPress);
        break;
      case ServiceType.dryCleaning:
        Navigator.pushNamed(context, Routes.dryCleaning);
        break;
    }
  }
}