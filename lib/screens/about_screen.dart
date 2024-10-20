import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  final List<String> teamMembers = ['Sourabh', 'Hitesh', 'Rohan  (Dry-clean & steam press specialist)','Mangla Ram', ];
  final Map<String, String> openingHours = {
    'Monday': '9:30 AM - 9:30 PM',
    'Tuesday': '9:30 AM - 9:30 PM',
    'Wednesday': '9:30 AM - 9:30 PM',
    'Thursday': '9:30 AM - 9:30 PM',
    'Friday': '9:30 AM - 9:30 PM',
    'Saturday': '9:30 AM - 9:30 PM',
    'Sunday': '9:30 AM - 9:30 PM',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Discover the ultimate laundry convenience with our shop! Enjoy quick,reliable service, and fresh,clean clothes. Drop off your laundry and letus handle the rest. Quality care and customer satisfaction gauaranteed'),
            SizedBox(height: 8,),
            Text(
              'SHRM Team',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.blueAccent),
            ),
            SizedBox(height: 8),
            
            ...teamMembers.map((member) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text('• $member', style: TextStyle(fontSize: 18)),
            )),
            SizedBox(height: 24),
            Text(
              'Address',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.blueAccent),
            ),
            SizedBox(height: 8),
            Text('Udaipur', style: TextStyle(fontSize: 18)),
            SizedBox(height: 24),
            Text(
              'Opening Hours',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.blueAccent),
            ),
            SizedBox(height: 8),
            ...openingHours.entries.map((entry) => ListTile(
              title: Text(entry.key),
              trailing: Text(entry.value),
            )),
            Text('Customer Care and Complaint Help Line Number', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.blueAccent),),
            Icon(Icons.phone),
            Text('+91 70910-59960')
          ],
        ),
      ),
          bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Offers'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
         onTap: (index) {
          switch (index) {
            case 0:
               Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/orders');
              break;
            case 2:
              Navigator.pushNamed(context, '/offers');
              break;
            case 3:
              Navigator.pushNamed(context, '/about');
              break;
            case 4:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}