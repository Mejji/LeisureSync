import 'package:flutter/material.dart';
import 'globals.dart';
import 'progress_tracker.dart';
import 'hobby_management.dart';
import 'calendar_screen.dart';
import 'notification_center.dart';
import 'edit_profile.dart'; // Import the edit_profile screen
import 'login_screen.dart'; // Import the login_screen
import 'home_screen.dart';

class developers extends StatelessWidget {
  final String username;
  const developers({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00AFDF),
        title: Text('Developers'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(username),
              accountEmail: null,
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 50.0,
                  color: Colors.blue,
                ),
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF00AFDF),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => home_screen(username: globalUsername)),
                );
              },
            ),
            ListTile(
              title: Text('Edit Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => edit_profile(username: globalUsername)),
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF00AFDF),
              Colors.white,
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.symmetric(vertical: 20),
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
                'LeisureSync Developers',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            DeveloperTile(name: 'Mark Josh Alvear', imagePath: 'images/Alvear.png'),
            SizedBox(height: 30), // Add space between developers
            DeveloperTile(name: 'Nigel Jan L. Naniong', imagePath: 'images/Naniong.png'),
            SizedBox(height: 30), // Add space between developers
            DeveloperTile(name: 'Andrei Christian Tonido', imagePath: 'images/Tonido.png'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.computer, color: Colors.blue),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          ),
        ],
        backgroundColor: Color(0xFF00AFDF),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => home_screen(username: globalUsername),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HobbyManagement(username: globalUsername),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => calendar_screen(username: globalUsername),
                ),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationCenter(username: globalUsername),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}

class DeveloperTile extends StatelessWidget {
  final String name;
  final String imagePath;

  DeveloperTile({required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey[200],
        backgroundImage: AssetImage(imagePath),
      ),
      title: Text(name),
    );
  }
}
