import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/User_model.dart';
import '../repository/userData_service.dart';

// Creating a FutureProvider to fetch the current user data
final currentUserProvider = FutureProvider<User?>((ref) async {
  // Accessing the UserDataService instance
  final userService = ref.watch(userDataServiceProvider);

  // Fetching the current user data
  final User? user = await userService.fetchCurrentUserData();

  return user;
});
