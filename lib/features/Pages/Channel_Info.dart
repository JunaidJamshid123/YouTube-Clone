import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../channel/SettingPage.dart';
import '../auth/Provider/user_provider.dart';

class ProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsyncValue = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        toolbarHeight: 0, // Hide app bar but keep status bar color
      ),
      body: currentUserAsyncValue.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        data: (user) {
          if (user == null) {
            return Center(child: Text('No user data available.'));
          }

          return DefaultTabController(
            length: 5, // Number of tabs
            child: Column(
              children: [
                // Profile Picture and Info
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: user.profilePic != null
                            ? NetworkImage(user.profilePic!)
                            : null,
                        backgroundColor: Colors.grey[300],
                        child: user.profilePic == null
                            ? Icon(Icons.person,
                                size: 40, color: Colors.grey[700])
                            : null,
                      ),
                      SizedBox(height: 10),
                      Text(
                        user.username,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),

                      // Row with Separate Text Widgets
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '@${user.username}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            '  ·  ',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            '${user.subscription.length} subscribers',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            '  ·  ',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            '${user.videos.length} videos',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'More about this channel',
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                    ],
                  ),
                ),

                // Buttons Section
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Manage Videos',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.grey[700]),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChannelSettingsPage()),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.bar_chart, color: Colors.grey[700]),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                Divider(),

                // Tab Bar Section
                TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.black,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  isScrollable: true,
                  tabs: [
                    Tab(text: 'Home'),
                    Tab(text: 'Videos'),
                    Tab(text: 'Shorts'),
                    Tab(text: 'Community'),
                    Tab(text: 'Playlists'),
                  ],
                ),

                // Tab Bar Views (Content for each tab)
                Expanded(
                  child: TabBarView(
                    children: [
                      Center(child: Text('Home Content')),
                      Center(child: Text('Videos Content')),
                      Center(child: Text('Shorts Content')),
                      Center(child: Text('Community Content')),
                      Center(child: Text('Playlists Content')),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
