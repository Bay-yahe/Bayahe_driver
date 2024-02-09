import 'package:driver/Booking/bookingscreen.dart';
import 'package:driver/Chat/chat_homepage.dart';
import 'package:driver/History/historyscreen.dart';
import 'package:driver/Home/homescreen.dart';
import 'package:driver/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const HomeTab(),
    const HistoryTab(),
    const BookingTab(),
    ChatHomepage(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Ensure _currentIndex is within the valid range
    if (_currentIndex < 0 || _currentIndex >= _tabs.length) {
      _currentIndex = 0; // Set a default value if it's out of range
    }

    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          // Ensure the selected index is within the valid range
          if (index >= 0 && index < _tabs.length) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.history),
            title: const Text('History'),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.book),
            title: const Text('Booking'),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.chat),
            title: const Text('Chat'),
            activeColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

// Define your tab classes (HomeTab, HistoryTab, BookingTab, ChatTab, ProfileTab) here.
// Make sure each tab class extends StatefulWidget and has its own unique content.
