import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'edit_profile.dart';
import 'home_screen.dart'; // Import the home_screen
import 'progress_tracker.dart'; // Import the progress_tracker screen
import 'hobby_management.dart'; // Import the calendar_screen
import 'notification_center.dart'; // Import the notification_center screen
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
        title: Text('Calendar Screen'),
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
              title: Text('Developers'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => developers(username: globalUsername)),
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
              Color(0xFF00AFDF), // Top color
              Colors.white, // Dominant semi-middle color
              Colors.white, // Dominant middle color
              Colors.white, // Dominant bottom color
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
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart, color: Colors.grey), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.groups, color: Colors.grey), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today, color: Colors.blue), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.grey), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications, color: Colors.grey), label: ''),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.blue,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => progress_tracker(username: globalUsername)),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HobbyManagement(username: globalUsername)),
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
                MaterialPageRoute(builder: (context) =>  NotificationCenter(username: globalUsername)),
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
            // Weekdays
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
            // Calendar Days
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
                      color: isToday ?  Color(0xFF00AFDF) : Colors.white,
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
