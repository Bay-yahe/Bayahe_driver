import 'package:driver/Home/IconPages/Booking/Google_Map.dart';
import 'package:driver/Home/IconPages/Booking/bottom_screen.dart';
import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookingDesign(),
    );
  }
}

class BookingDesign extends StatelessWidget {
  const BookingDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Route Map',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
        ),
        body: const Stack(
          children: [
            ImageViewer(),
            BottomScreen(),
          ],
        ),
      ),
    );
  }
}
