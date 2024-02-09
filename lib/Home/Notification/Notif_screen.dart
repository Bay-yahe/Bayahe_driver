import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildListWithTitle('Booking System', _buildBookingSystemList()),
            _buildListWithTitle(
                'System Notification', _buildSystemNotificationList()),
          ],
        ),
      ),
    );
  }

  Widget _buildListWithTitle(String title, Widget list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200, // Adjust the height as needed
          child: list,
        ),
      ],
    );
  }

  Widget _buildBookingSystemList() {
    // Replace this with your actual list widget for Booking System
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Booking System Item $index'),
        );
      },
    );
  }

  Widget _buildSystemNotificationList() {
    // Replace this with your actual list widget for System Notification
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('System Notification Item $index'),
        );
      },
    );
  }
}
