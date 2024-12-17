import 'package:flutter/material.dart';
import 'Creative_hf.dart';
import 'Physical_hf.dart';
import 'Relaxing_hf.dart';
import 'home_screen.dart';
import 'progress_tracker.dart';
import 'calendar_screen.dart';
import 'notification_center.dart';
import 'time_hobby.dart';
import 'globals.dart';

class ListHobbies extends StatefulWidget {
  final String selectedCategory;
  final String username;
  const ListHobbies({super.key, required this.selectedCategory, required this.username});

  @override
  State<ListHobbies> createState() => _ListHobbiesState();
}

class _ListHobbiesState extends State<ListHobbies> {
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
        backgroundColor: const Color(0xFF00AFDF),
        title: const Text('List of Hobbies'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            switch (widget.selectedCategory) {
              case 'Relaxing_hf':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Relaxing_hf(username: widget.username)),
                );
                break;
              case 'Physical_hf':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Physical_hf(username: widget.username)),
                );
                break;
              case 'Creative_hf':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Creative_hf(username: widget.username)),
                );
                break;
              default:
                Navigator.pop(context);
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: hobbies.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 16.0,
                      ),
                      title: Text(
                        hobbies[index],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        // Navigate to time_hobby.dart screen when a hobby is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TimerHobby(username: widget.username, selectedCategory: '',)
                          ),
                        );
                      },
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => _deleteHobby(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addHobby,
        backgroundColor: const Color(0xFF00AFDF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.groups, color: Colors.blue),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications),
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
                MaterialPageRoute(builder: (context) => progress_tracker(username: widget.username)),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => home_screen(username: widget.username),
                ),
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