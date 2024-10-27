import 'package:flutter/material.dart';

class ChannelSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color.fromARGB(255, 207, 211, 218), Color.fromARGB(255, 231, 239, 242)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          Positioned(
            top: 100,
            left: 16,
            right: 16,
            child: Column(
              children: [
                // Profile picture with a border and camera icon
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                            'assets/images/profile.png'), // Add your profile image
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 18,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.blueAccent,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // Information section with card style
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Name section
                      _buildEditableField('Name', 'Channel Name'),
                      Divider(color: Colors.grey.shade300),
                      // Handle section
                      _buildEditableField('Handle', 'devcoder'),
                      Divider(color: Colors.grey.shade300),
                      // Description section
                      _buildEditableField(
                          'Description', 'Hello, welcome to my channel!'),
                      Divider(color: Colors.grey.shade300),
                      // Toggle section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Keep all my subscribers private',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Switch(
                            value: false,
                            onChanged: (value) {
                              // Handle toggle change
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Bottom text section with decorative icon
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline, color: Colors.black),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Changes made to your name and profile picture '
                          'are visible only to YouTube, not other Google Services.',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Icon(Icons.edit, color: Colors.blueAccent),
      ],
    );
  }
}
