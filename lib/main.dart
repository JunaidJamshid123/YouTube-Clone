// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userAsyncValue.when(
        data: (user) => user != null ? ChannelSettingsPage() : LoginPage(),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
