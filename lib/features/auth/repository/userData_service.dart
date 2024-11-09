import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    as firebaseAuth; // Rename alias to avoid conflict
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/User_model.dart'
    as custom; // Alias your custom User model as custom.User

final userDataServiceProvider = Provider<UserDataService>((ref) {
  return UserDataService(
    auth: firebaseAuth.FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

class UserDataService {
  final firebaseAuth.FirebaseAuth auth; // Use firebaseAuth for FirebaseAuth
  final FirebaseFirestore firestore;

  UserDataService({required this.auth, required this.firestore});

 // Check if the username is available
  Future<bool> isUsernameAvailable(String username) async {
    try {
      final querySnapshot = await firestore.collection('users')
          .where('username', isEqualTo: username)
          .get();
      return querySnapshot.docs.isEmpty;
    } catch (e) {
      print('Error checking username availability: $e');
      return false;
    }
  }

  // Add user data to Firestore
  Future<void> addUserToFirestore(custom.User user) async {
    try {
      await firestore.collection('users').doc(user.userId).set(user.toMap());
      print('User data added to Firestore successfully');
    } catch (e) {
      print('Error adding user data to Firestore: $e');
    }
  }
  

  // Update user data in Firebase Firestore
  Future<void> updateUserInFirestore(custom.User user) async {
    try {
      await firestore.collection('users').doc(user.userId).update(user.toMap());
      print('User data updated in Firestore successfully');
    } catch (e) {
      print('Error updating user data in Firestore: $e');
    }
  }

  // Retrieve user data from Firebase Firestore by userId
  Future<custom.User?> getUserFromFirestore(String userId) async {
    try {
      final doc = await firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return custom.User.fromMap(doc.data()!);
      }
    } catch (e) {
      print('Error retrieving user data from Firestore: $e');
    }
    return null;
  }

  // Delete user data from Firebase Firestore by userId
  Future<void> deleteUserFromFirestore(String userId) async {
    try {
      await firestore.collection('users').doc(userId).delete();
      print('User data deleted from Firestore successfully');
    } catch (e) {
      print('Error deleting user data from Firestore: $e');
    }
  }
}
