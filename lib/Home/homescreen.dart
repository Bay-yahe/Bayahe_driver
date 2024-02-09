import 'package:driver/Home/Ads/ads_box.dart';
import 'package:driver/Home/Ads/route_terminal.dart';
import 'package:driver/Home/Box/HomeIcon.dart';
import 'package:driver/Home/Notification/Notif_screen.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key, Key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/Logo/logo.png',
                width: 50,
                height: 50,
              ),
            ),
            const Text('Welcome!'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.cyan,
            ),
            onPressed: () {
              // Add your notification icon onPressed logic here
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationScreen()));
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeIcon(),
            SizedBox(height: 10),
            Divider(
              thickness: 2,
              indent: 3,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
              child: Text(
                'Driver Partners',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ImageScroll(),
            Divider(
              thickness: 2,
              indent: 3,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
              child: Text(
                'Route Landmarks',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Landmarks(),
          ],
        ),
      ),
    );
  }
}
