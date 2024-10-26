import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        toolbarHeight: 0, // Hide app bar but keep status bar color
      ),
      body: Column(
        children: [
          // Profile Picture and Info
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 40, color: Colors.grey[700]),
                ),
                SizedBox(height: 10),
                Text(
                  'Ahmad Amini',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 5),

                // Row with Separate Text Widgets
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '@ahmad-amini',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Text(
                      '  ·  ',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Text(
                      'No subscriptions',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Text(
                      '  ·  ',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Text(
                      'No videos',
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                  onPressed: () {},
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
            controller: _tabController,
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
              controller: _tabController,
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
  }
}
