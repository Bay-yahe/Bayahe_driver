import 'package:driver/Navbar/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tricycle Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.blue, // Set your accent color here
      ),
      home: IntroductionScreenPage(),
    );
  }
}

class IntroductionScreenPage extends StatelessWidget {
  final List<PageViewModel> pages = [
    PageViewModel(
      title: "Page 1",
      body: "Description for page 1",
      image: Image.asset(
          "assets/Images/tri1.jpg"), // Replace with your image asset
    ),
    PageViewModel(
      title: "Page 2",
      body: "Description for page 2",
      image: Image.asset(
          "assets/Images/tri1.jpg"), // Replace with your image asset
    ),
    PageViewModel(
      title: "Page 3",
      body: "Description for page 3",
      image: Image.asset(
          "assets/Images/tri1.jpg"), // Replace with your image asset
    ),
  ];

  IntroductionScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: pages,
      onDone: () {
        // Handle what to do when the user taps Done
        // e.g., navigate to the home screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      },
      onSkip: () {
        // Handle what to do when the user taps Skip
        // e.g., navigate to the home screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      },
      showSkipButton: true,
      skip: const Icon(Icons.skip_next),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
        size: const Size(10.0, 10.0),
        color: Colors.grey,
        activeColor: Theme.of(context).colorScheme.secondary,
        activeSize: const Size(22.0, 10.0),
        activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
