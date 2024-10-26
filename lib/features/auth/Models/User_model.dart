import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String displayName;
  final String username;
  final String email;
  final String profilePic;
  final List<String> subscription;
  final String videos;
  final String userId;
  final String description;
  final String type;

  // Constructor
  User({
    required this.displayName,
    required this.username,
    required this.email,
    required this.profilePic,
    required this.subscription,
    required this.videos,
    required this.userId,
    required this.description,
    required this.type,
  });

  // Convert User instance to Map
  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'username': username,
      'email': email,
      'profilePic': profilePic,
      'subscription': subscription,
      'videos': videos,
      'userId': userId,
      'description': description,
      'type': type,
    };
  }

  // Convert Map to User instance
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      displayName: map['displayName'],
      username: map['username'],
      email: map['email'],
      profilePic: map['profilePic'],
      subscription: List<String>.from(map['subscription']),
      videos: map['videos'],
      userId: map['userId'],
      description: map['description'],
      type: map['type'],
    );
  }
}