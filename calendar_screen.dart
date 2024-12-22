import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'edit_profile.dart';
import 'home_screen.dart';
import 'progress_tracker.dart';
import 'hobby_management.dart';
import 'notification_center.dart';
import 'globals.dart';
import 'developers.dart';

class calendar_screen extends StatefulWidget {
  final String username;
  const calendar_screen({super.key, required this.username});

  @override
  State<calendar_screen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<calendar_screen> {
  final DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Screen'),
        backgroundColor: const Color(0xFF00AFDF),
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
                  MaterialPageRoute(builder: (context) => Developers(username: widget.username)),
                );
              },
            ),
            ListTile(
              title: const Text('Edit Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => edit_profile(username: widget.username)),
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
              Color(0xFF00AFDF),
              Colors.white,
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(),
              _buildCalendarTitle(),
              _buildCalendarGrid(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.blue),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.grey),
            label: '',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.blue,
        onTap: (index) {
          // Logic to switch screens based on the selected tab
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

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "14:14",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarTitle() {
    final month = _currentDate.month;
    final year = _currentDate.year;
    final monthName = _getMonthName(month);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: Text(
          "$monthName $year",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June', 'July',
      'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames[month - 1];
  }

  Widget _buildCalendarGrid() {
    final daysInMonth = DateTime(_currentDate.year, _currentDate.month + 1, 0).day;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text("Sun", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Mon", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Tue", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Wed", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Thu", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Fri", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Sat", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: daysInMonth,
                itemBuilder: (context, index) {
                  final day = index + 1;
                  final isToday = day == _currentDate.day;

                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isToday ? const Color(0xFF00AFDF) : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(
                      "$day",
                      style: TextStyle(
                        fontSize: 16,
                        color: isToday ? Colors.white : Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
