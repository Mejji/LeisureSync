import 'package:flutter/material.dart';
import 'package:leisuresync/hobby_management.dart';
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
    showDialog(
      context: context,
      builder: (context) {
        String newHobby = ""; // Store the input hobby name
        return AlertDialog(
          title: const Text('Add New Hobby'),
          content: TextField(
            onChanged: (value) {
              newHobby = value;
            },
            decoration: const InputDecoration(hintText: "Enter hobby name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                setState(() {
                  hobbies.add(newHobby);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                        // Navigate to time_hobby.dart screen and pass the hobby name
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TimerHobby(
                              username: widget.username,
                              selectedCategory: hobbies[index], // Pass the hobby name here
                            ),
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
      // ... (rest of your code)
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups, color: Colors.blue),
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
            icon: Icon(Icons.notifications, color: Colors.grey),
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