import 'package:flutter/material.dart';
import 'hobby_management.dart'; // Import the home_management screen
import 'home_screen.dart';
import 'calendar_screen.dart'; // Import the calendar_screen
import 'notification_center.dart'; // Import the notification_center screen
import 'login_screen.dart';
import 'edit_profile.dart';
import 'globals.dart';

class progress_tracker extends StatefulWidget {
  @override
  _progress_trackerState createState() => _progress_trackerState();
}

class _progress_trackerState extends State<progress_tracker> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Robot Page'),
    Text('Home Page'),
    Text('Calendar Page'),
    Text('Notifications Page'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Tracker'),
        backgroundColor: Color(0xFF00AFDF),

      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('User'),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 50.0,
                  color: Colors.blue,
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF00AFDF),
              ),
            ),
            ListTile(
              title: Text('Account'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const edit_profile()),
                );
              },
            ),
            ListTile(
              title: Text('Edit Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const edit_profile()),
                );
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF00AFDF), // Top color
              Colors.white, // Dominant semi-middle color
              Colors.white, // Dominant middle color
              Colors.white, // Dominant bottom color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Hobby Categories Header
              Container(
                width: MediaQuery.of(context).size.width * 0.8, // Extend the width
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Text(
                  'Progress Tracker',
                  textAlign: TextAlign.center, // Center align the text
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 170), // Moved up

              Container(
                height: 200,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
              SizedBox(height: 20),
              Text(
                'Hobby: Basketball',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Time Spent: 30 Minutes',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.room, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: Colors.blue),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.grey),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (_onItemTapped){
          switch (_onItemTapped) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HobbyManagement(),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => home_screen(username: globalUsername), // Use the global variable
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const calendar_screen(),
                ),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationCenter(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}

class BarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Bar(color: Colors.red, height: 150),
        Bar(color: Colors.blue, height: 50),
        Bar(color: Colors.green, height: 100),
        Bar(color: Colors.yellow, height: 150),
        Bar(color: Colors.purple, height: 20),
      ],
    );
  }
}

class Bar extends StatelessWidget {
  final Color color;
  final double height;

  Bar({required this.color, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: height,
      color: color,
    );
  }
}
