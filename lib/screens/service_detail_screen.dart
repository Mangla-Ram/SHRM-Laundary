import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

enum ServiceType { laundry, shoeCleaning, steamPress, dryCleaning }

class ServiceDetailScreen extends StatefulWidget {
  final ServiceType serviceType;

  ServiceDetailScreen({required this.serviceType});

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  Map<String, int> itemCounts = {
    'Shirt': 0,
    'Pants': 0,
    'Jacket': 0,
    'Saree': 0,
    'Kurta': 0,
    'Coat': 0,
    'Dress': 0,
    'Sweater': 0,
    'Other': 0,
  };

  String? otherItemType;
  int pricePerPiece = 50;
  bool shoesWash = false;
  bool shoesClean = false;
  int steamPressCount = 0;
  int dryCleanCount = 0;

  @override
  void initState() {
    super.initState();
    _loadSavedState();
  }

  Future<void> _loadSavedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Load item counts and service options from local storage
    String? savedItems = prefs.getString('savedItemCounts');
    if (savedItems != null) {
      setState(() {
        itemCounts = Map<String, int>.from(jsonDecode(savedItems));
      });
    }

    setState(() {
      shoesWash = prefs.getBool('shoesWash') ?? false;
      shoesClean = prefs.getBool('shoesClean') ?? false;
    });
  }

  Future<void> _saveState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save item counts and other options locally
    await prefs.setString('savedItemCounts', jsonEncode(itemCounts));
    await prefs.setBool('shoesWash', shoesWash);
    await prefs.setBool('shoesClean', shoesClean);
  }

  @override
  Widget build(BuildContext context) {
    String serviceTitle = getServiceTitle();
    int totalPrice = calculateTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: Text(serviceTitle),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              serviceTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _buildServiceSpecificWidgets(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Total Price: ₹$totalPrice',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _saveState();
                // Navigate to the next page or perform other actions here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NextPage()),
                );
              },
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }

  String getServiceTitle() {
    switch (widget.serviceType) {
      case ServiceType.laundry:
        return 'Laundry Service';
      case ServiceType.shoeCleaning:
        return 'Shoe Cleaning Service';
      case ServiceType.steamPress:
        return 'Steam Press Service';
      case ServiceType.dryCleaning:
        return 'Dry Cleaning Service';
    }
  }

  List<Widget> _buildServiceSpecificWidgets() {
    switch (widget.serviceType) {
      case ServiceType.laundry:
      case ServiceType.steamPress:
      case ServiceType.dryCleaning:
        return [
          _buildClothTypeTile('Shirt'),
          _buildClothTypeTile('Pants'),
          _buildClothTypeTile('Jacket'),
          _buildClothTypeTile('Saree'),
          _buildClothTypeTile('Kurta'),
          _buildClothTypeTile('Coat'),
          _buildClothTypeTile('Dress'),
          _buildClothTypeTile('Sweater'),
          _buildClothTypeTile('Other'),
          if (itemCounts['Other']! > 0) _buildOtherClothTypeField(),
        ];
      case ServiceType.shoeCleaning:
        return [_buildShoesCard()];
    }
  }

  Widget _buildClothTypeTile(String clothType) {
    return ListTile(
      title: Text(clothType),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove, color: Colors.redAccent),
            onPressed: () {
              setState(() {
                if (itemCounts[clothType]! > 0) {
                  itemCounts[clothType] = itemCounts[clothType]! - 1;
                }
              });
            },
          ),
          Text(
            itemCounts[clothType].toString(),
            style: TextStyle(fontSize: 18, color: Colors.blueAccent),
          ),
          IconButton(
            icon: Icon(Icons.add, color: Colors.blueAccent),
            onPressed: () {
              setState(() {
                itemCounts[clothType] = itemCounts[clothType]! + 1;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOtherClothTypeField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Specify other item type',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          setState(() {
            otherItemType = value;
          });
        },
      ),
    );
  }

  Widget _buildShoesCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shoe Cleaning Options',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: Text('Wash (₹100)'),
              value: shoesWash,
              onChanged: (bool? value) {
                setState(() {
                  shoesWash = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Clean (₹150)'),
              value: shoesClean,
              onChanged: (bool? value) {
                setState(() {
                  shoesClean = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  int calculateTotalPrice() {
    switch (widget.serviceType) {
      case ServiceType.laundry:
        return itemCounts.values.fold(0, (sum, count) => sum + count) * pricePerPiece;
      case ServiceType.shoeCleaning:
        return (shoesWash ? 100 : 0) + (shoesClean ? 150 : 0);
      case ServiceType.steamPress:
        return itemCounts.values.fold(0, (sum, count) => sum + count) * 30;
      case ServiceType.dryCleaning:
        return itemCounts.values.fold(0, (sum, count) => sum + count) * 200;
    }
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text('Next step after continue'),
      ),
    );
  }
}
