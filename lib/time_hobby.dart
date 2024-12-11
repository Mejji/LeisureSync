import 'package:flutter/material.dart';
import 'dart:async';
import 'progress_tracker.dart';  // Import the Progress Tracker screen
import 'home_screen.dart';
import 'calendar_screen.dart';
import 'notification_center.dart';
import 'login_screen.dart';
import 'edit_profile.dart';
import 'globals.dart';

class TimerHobby extends StatefulWidget {
  @override
  _TimerHobbyState createState() => _TimerHobbyState();
}

class _TimerHobbyState extends State<TimerHobby> {
  Timer? _timer;
  int _start = 1800; // 30 minutes in seconds
  bool _isRunning = false;

  void startTimer() {
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isRunning = false;
        });
        _timer?.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void stopTimer() {
    setState(() {
      _isRunning = false;
      _timer?.cancel();
      _start = 1800; // Reset to 30 minutes
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => progress_tracker()),
    );
  }

  void pauseTimer() {
    setState(() {
      _isRunning = false;
      _timer?.cancel();
    });
  }

  void resetTimer() {
    setState(() {
      _isRunning = false;
      _timer?.cancel();
      _start = 1800; // Reset to 30 minutes
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  double get progress {
    return (_start / 1800);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basketball Timer'),
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
              Color(0xFF00AFDF),
              Colors.white,
              Colors.white,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Basketball Practice Timer',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Progress bar
              Container(
                width: 300,
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  color: Colors.blue,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 20),
              // Timer display
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  formatTime(_start),
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isRunning ? pauseTimer : startTimer,
                    child: Text(_isRunning ? 'PAUSE' : 'START'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: resetTimer,
                    child: Text('RESET'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: stopTimer,
                    child: Text('STOP'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart, color: Colors.grey),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blue),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.grey),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.grey),
            label: 'Notifications',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
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
                MaterialPageRoute(
                  builder: (context) => home_screen(username: globalUsername), // Use the global variable
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const calendar_screen()),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationCenter()),
              );
              break;
          }
        },
      ),
    );
  }
}
