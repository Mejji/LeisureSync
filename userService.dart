import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Globals.dart';  // Import the Globals class

class UserService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Fetch the username from Firebase and update the global variable
  Future<void> fetchUsername(String globalUsername) async {
    try {
      // Fetch the user document from Firestore based on the global username
      DocumentSnapshot userDoc = await _firebaseFirestore
          .collection('users')  // Change this to your collection name
          .doc(globalUsername)  // Use the globalUsername as the document ID
          .get();

      // Check if the document exists and update the global username
      if (userDoc.exists) {
        Globals.username = userDoc['username'] ?? 'No username found';
      } else {
        Globals.username = 'User not found';
      }
    } catch (e) {
      print('Error fetching username: $e');
      Globals.username = 'Error fetching username';
    }
  }
}
