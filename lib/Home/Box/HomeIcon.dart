import 'package:driver/Home/IconPages/Passenger/passenger_list.dart';
import 'package:driver/Home/IconPages/Tricycle/tricycle_output.dart';
import 'package:flutter/material.dart';

class HomeIcon extends StatefulWidget {
  const HomeIcon({super.key, Key});

  @override
  State<HomeIcon> createState() => _HomeIconState();
}

class _HomeIconState extends State<HomeIcon> {
  Widget buildImageButton(
      String imagePath, String buttonText, VoidCallback onPressed) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Ink.image(
            image: AssetImage(imagePath),
            width: 40.0,
            height: 40.0,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: onPressed,
            ),
          ),
        ),
        Text(
          buttonText,
          style: const TextStyle(fontSize: 12.0),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildImageButton(
              'assets/Logo/passenger.png',
              'Passenger',
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Passenger(),
                ),
              ),
            ),
            buildImageButton(
              'assets/Logo/tricycle.png',
              'Tricycle',
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TricycleDetailsScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
