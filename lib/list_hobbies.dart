import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'progress_tracker.dart';
import 'calendar_screen.dart';
import 'notification_center.dart';
import 'time_hobby.dart';
import 'login_screen.dart';
import 'edit_profile.dart';
import 'globals.dart';
import 'developers.dart';

class list_hobbies extends StatefulWidget {
  final String username;
  const list_hobbies({super.key, required this.username});

  @override
  State<list_hobbies> createState() => _list_hobbiesState();
}

class _list_hobbiesState extends State<list_hobbies> {
  final List<String> hobbies = ["Playing Guitar", "Basketball", "Singing", "Yoga"];

  void _deleteHobby(int index) {
    setState(() {
      hobbies.removeAt(index);
    });
  }

  void _addHobby() {
    setState(() {
      hobbies.add("New Hobby");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00AFDF),
        title: Text('List of Hobbies'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();  // Opens the Drawer when menu icon is clicked
            },
          ),
        ),
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
                  MaterialPageRoute(builder: (context) =>  developers(username: globalUsername)),
                );
              },
            ),
            ListTile(
              title: Text('Edit Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  edit_profile(username: globalUsername)),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: hobbies.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(hobbies[index]),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TimerHobby(username: globalUsername)),
                            );
                          },
                          child: Text('Begin Tracking'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (hobbies.isNotEmpty) {
                        _deleteHobby(0);  // Deletes the first hobby for now, you can add more logic
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Delete'),
                  ),
                  ElevatedButton(
                    onPressed: _addHobby, // Adds a new hobby to the list
                    child: Text('Add'),
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
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note, color: Colors.blue),
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
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
                MaterialPageRoute(
                  builder: (context) => home_screen(username: globalUsername), // Use the global variable
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => calendar_screen(username: globalUsername)),
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
}