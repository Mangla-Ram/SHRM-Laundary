import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shrm/screens/service_detail_screen.dart';
import '../widgets/service_card_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> services = [
    {'title': 'Dry Clean', 'image': 'assets/images/dry_clean.png', 'type': ServiceType.dryCleaning},
    {'title': 'Steam Press', 'image': 'assets/images/steam_press.png', 'type': ServiceType.steamPress},
    {'title': 'Laundry', 'image': 'assets/images/laundry.png', 'type': ServiceType.laundry},
    {'title': 'Shoe Cleaning', 'image': 'assets/images/shoe_cleaning.png', 'type': ServiceType.shoeCleaning},
  ];

  final List<String> locations = ['NSCB', 'PG', 'Ganga', 'M.V', 'ANK'];
  String selectedLocation = 'NSCB';
  late AnimationController _controller;
  late Animation<double> _animation;

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.location_on, color: Colors.black),
              DropdownButton<String>(
                value: selectedLocation,
                items: locations.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLocation = newValue!;
                  });
                  _scaffoldMessengerKey.currentState?.showSnackBar(
                    SnackBar(content: Text('Selected location: $newValue')),
                  );
                },
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Handle notification icon press
              },
            ),
          ],
          backgroundColor: Colors.blueAccent,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to,',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    colors: [Colors.blue, Colors.green],
                                    stops: [_animation.value, _animation.value + 0.5],
                                  ).createShader(bounds);
                                },
                                child: Text(
                                  'SHRM Laundry',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Image.asset('assets/logo.png', width: 60, height: 60),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Choose Your Service',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: services.length,
                      itemBuilder: (ctx, index) {
                        return AnimatedOpacity(
                          opacity: 0.3 + (_animation.value * 0.3),
                          duration: Duration(milliseconds: 800),
                          child: AnimatedScale(
                            scale: 0.8 + (_animation.value * 0.2),
                            duration: Duration(milliseconds: 800),
                            child: ServiceCardWidget(
                              title: services[index]['title']!,
                              imagePath: services[index]['image']!,
                              serviceType: services[index]['type'] as ServiceType,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset('assets/logo.png', width: 60, height: 60),
                          SizedBox(width: 16),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 50)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'FLAT 20% OFF ON FIRST ORDER',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text('Use code: FST20'),
                                ElevatedButton(
                                  child: Text('Copy Code'),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: 'FST20'));
                                    _scaffoldMessengerKey.currentState?.showSnackBar(
                                      SnackBar(content: Text('Code copied to clipboard')),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              label: 'Offers',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                // Already on home screen
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
      ),
    );
  }
}
