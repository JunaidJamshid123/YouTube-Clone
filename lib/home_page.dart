// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/cores/widgets/image_button.dart';
import './features/auth/Provider/user_provider.dart'; // Update the import path based on your file structure
import './features/Pages/Channel_Info.dart'; // Import the Channel_Info.dart file

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                // YouTube logo
                Image.asset(
                  "assets/images/youtube.jpg",
                  height: 36,
                ),
                const SizedBox(width: 4),
                const Spacer(),
                // Cast icon
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SizedBox(
                    height: 42,
                    child: ImageButton(
                      image: "cast.png",
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                ),
                // Notification icon
                SizedBox(
                  height: 38,
                  child: ImageButton(
                    image: "notification.png",
                    onPressed: () {},
                    haveColor: false,
                  ),
                ),
                // Search icon
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 15),
                  child: SizedBox(
                    height: 41.5,
                    child: ImageButton(
                      image: "search.png",
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                ),
                // Circle Avatar with User Profile Picture and Navigation
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Consumer(
                    builder: (context, ref, _) {
                      final currentUser = ref.watch(currentUserProvider);

                      return currentUser.when(
                        data: (user) {
                          if (user != null && user.profilePic != null) {
                            return GestureDetector(
                              onTap: () {
                                // Navigate to the Channel Info Page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 18,
                                backgroundImage: NetworkImage(user.profilePic!),
                                backgroundColor: Colors.transparent,
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                // Navigate to the Channel Info Page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor:
                                    const Color.fromARGB(157, 217, 69, 69),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                        },
                        loading: () => const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                        error: (err, stack) => CircleAvatar(
                          radius: 18,
                          backgroundColor:
                              const Color.fromARGB(157, 217, 69, 69),
                          child: const Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
