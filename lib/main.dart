import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youtube_clone/features/auth/username_Page.dart';
import 'features/auth/login_page.dart';
import 'home_page.dart';
import './features/auth/repository/providers.dart';
import './features/Pages/Channel_Info.dart';
import './features/channel/SettingPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider);
    final userProfileAsyncValue = ref.watch(userProfileProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userAsyncValue.when(
        data: (user) {
          if (user == null) {
            // User is not logged in
            return LoginPage();
          } else {
            // Check if user has a username
            return userProfileAsyncValue.when(
              data: (hasUsername) {
                if (hasUsername) {
                  // User is registered and has a username, go to home
                  return HomePage();
                } else {
                  // User is registered but hasn't set a username, go to UsernamePage
                  return UsernameScreen();
                }
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
            );
          }
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
