import 'package:flutter/material.dart';
import 'package:leisuresync/developers.dart';
import 'globals.dart';
import 'hobby_management.dart';
import 'progress_tracker.dart';
import 'calendar_screen.dart';
import 'notification_center.dart';
import 'login_screen.dart';
import 'edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class home_screen extends StatefulWidget {
  final String username;
  const home_screen({super.key, required this.username});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00AFDF),
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(widget.username),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/chillguy.png'),
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF00AFDF),
              ),
            ),
            ListTile(
              title: const Text('Developers'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Developers(
                        username: widget.username,
                      )),
                );
              },
            ),
            ListTile(
              title: const Text('Edit Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => edit_profile(
                        username: widget.username,
                      )),
                );
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () async {
                // Sign out using Firebase
                await FirebaseAuth.instance.signOut();
                // Navigate to LoginScreen after signing out
                Navigator.pushReplacement(
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
              Color(0xFF00AFDF), // Top color
              Colors.white, // Dominant semi-middle color
              Colors.white, // Dominant middle color
              Colors.white, // Dominant bottom color
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${widget.username}', // Display username here
              style: TextStyle(
                fontSize: size.width * 0.06, // Responsive font size
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            CircleAvatar(
              radius: size.width * 0.3, // Responsive size for the avatar
              backgroundImage: AssetImage('images/chillguy.png'),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Text(
                "It's a brand new day full of possibilities, let's own it! Gear up, set the vibe, and make it amazing! 🎉🚀✨",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.04, // Responsive font size
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: Colors.grey),
            label: '', // Removed the label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity, color: Colors.grey),
            label: '', // Removed the label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: '', // Removed the label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.grey),
            label: '', // Removed the label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.grey),
            label: '', // Removed the label
          ),
        ],
        backgroundColor: const Color(0xFF00AFDF),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProgressTracker(
                    username: widget.username,
                  ),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HobbyManagement(
                    username: widget.username,
                  ),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => calendar_screen(
                    username: widget.username,
                  ),
                ),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationCenter(
                    username: widget.username,
                  ),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
