import 'package:flutter/material.dart';
import 'calendar_screen.dart';
import 'login_screen.dart';
import 'edit_profile.dart';
import 'home_screen.dart'; // Import the home_screen
import 'progress_tracker.dart'; // Import the progress_tracker screen
import 'hobby_management.dart'; // Import the calendar_screen
import 'globals.dart';


class NotificationCenter extends StatefulWidget {
  const NotificationCenter({super.key});

  @override
  State<NotificationCenter> createState() => _NotificationCenterState();
}

class _NotificationCenterState extends State<NotificationCenter> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      icon: Icons.fitness_center,
      title: "It’s Time to Build up Some Muscles",
      description:
      "Time to shake off the cobwebs and get moving! Workout mode activated! Let’s make it count! 💪🔥",
    ),
    NotificationItem(
      icon: Icons.self_improvement,
      title: "It’s Time to Relax",
      description:
      "Time to unwind and let go. Relaxation mode on. Breathe in calm, breathe out stress. You’ve earned this! 🌿✨",
    ),
    NotificationItem(
      icon: Icons.calendar_today,
      title: "Hobby Scheduled!!",
      description: "Your hobby has been successfully scheduled!",
    ),
    NotificationItem(
      icon: Icons.person,
      title: "Profile Updated!!",
      description: "Your profile has been successfully updated!",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Center'),
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
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 2.0,
              child: ListTile(
                leading: Icon(notification.icon, color: Colors.blue),
                title: Text(
                  notification.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(notification.description),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart, color: Colors.grey), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.groups, color: Colors.grey), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications, color: Colors.blue), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.grey), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today, color: Colors.grey), label: ''),
        ],
        currentIndex: 2, // Set Bell as the selected item
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => progress_tracker()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HobbyManagement()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => home_screen(username: globalUsername), // Use the global variable
                ),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const calendar_screen()),
              );
              break;
          }
        },
      ),
    );
  }
}

class NotificationItem {
  final IconData icon;
  final String title;
  final String description;

  NotificationItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}
