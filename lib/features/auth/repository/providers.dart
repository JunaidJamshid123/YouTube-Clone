import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart';

// AuthService provider to access sign-in and sign-out methods
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    auth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(),
  );
});

// User state provider to listen for changes in sign-in status
final userProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.auth.authStateChanges();
});

// User profile check provider to verify if the user has completed username setup
final userProfileProvider = FutureProvider<bool>((ref) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    return userDoc.exists && userDoc.data()!['username'] != null;
  }
  return false;
});
