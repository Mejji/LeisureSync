import 'package:flutter/material.dart';
import 'calendar_screen.dart';
import 'login_screen.dart';
import 'edit_profile.dart';
import 'home_screen.dart'; // Import the home_screen
import 'progress_tracker.dart'; // Import the progress_tracker screen
import 'hobby_management.dart'; // Import the calendar_screen
import 'globals.dart';
import 'developers.dart';


class NotificationCenter extends StatefulWidget {
  final String username;
  const NotificationCenter({super.key, required this.username});

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
              accountName: Text(widget.username),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/chillguy.png'),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF00AFDF),
              ),
            ),
            ListTile(
              title: Text('Developers'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Developers(username: widget.username)),
                );
              },
            ),
            ListTile(
              title: Text('Edit Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  edit_profile(username: widget.username)),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity, color: Colors.grey),
            label: 'hobbies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.blue),
            label: '',
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
                MaterialPageRoute(builder: (context) => ProgressTracker(username: widget.username)),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HobbyManagement(username: widget.username)),
              );
              break;
            case 2: // Home screen case
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => home_screen(username: widget.username)),
                    (Route<dynamic> route) => false, // Remove all previous screens
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => calendar_screen(username: widget.username)),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationCenter(username: widget.username)),
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