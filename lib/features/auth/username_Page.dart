import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './Models/User_model.dart'
    as custom; // Alias your custom User model as custom.User
import './repository/userData_service.dart'; // Make sure to import your service provider

class UsernameScreen extends ConsumerStatefulWidget {
  @override
  _UsernameScreenState createState() => _UsernameScreenState();
}

class _UsernameScreenState extends ConsumerState<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();
  bool isUsernameAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the username',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Insert username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                suffixIcon: Icon(
                  isUsernameAvailable ? Icons.check_circle : Icons.cancel,
                  color: isUsernameAvailable ? Colors.green : Colors.red,
                ),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  await validateUsername();
                },
                child: Text(
                  'CONTINUE',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> validateUsername() async {
    final userDataService = ref.read(userDataServiceProvider);
    final username = _usernameController.text.trim();

    if (username.isNotEmpty) {
      final isAvailable = await userDataService.isUsernameAvailable(username);
      setState(() {
        isUsernameAvailable = isAvailable;
      });

      if (isAvailable) {
        final currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser != null) {
          // Create a new user instance with Google Sign-In details
          final newUser = custom.User(
            displayName: currentUser.displayName ?? 'No Name',
            username: username,
            email: currentUser.email ?? '',
            profilePic: currentUser.photoURL ?? '',
            subscription: [], // Empty subscription list
            videos: [], // Empty videos list
            userId: currentUser.uid,
            description:
                '', // Set default description or add field for user input
            type: 'Google', // Identifying the sign-in type
          );

          // Add user to Firestore
          await userDataService.addUserToFirestore(newUser);
          print('User added to Firestore successfully');
        } else {
          print('No user found for Google Sign-In');
        }
      } else {
        print('Username is already taken, please choose another');
      }
    }
  }
}
