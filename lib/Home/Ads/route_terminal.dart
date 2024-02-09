import 'package:flutter/material.dart';

class Landmarks extends StatefulWidget {
  const Landmarks({super.key});

  @override
  _LandmarksState createState() => _LandmarksState();
}

class _LandmarksState extends State<Landmarks> {
  final PageController _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.8,
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          // Update the page controller based on the drag gesture
          _pageController.position
              .applyViewportDimension(details.primaryDelta! / 2);
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: 5,
          itemBuilder: (context, index) {
            return buildImage(index);
          },
        ),
      ),
    );
  }

  Widget buildImage(int index) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          getImagePath(index),
          width: 150.0,
          height: 200.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  String getImagePath(int index) {
    switch (index) {
      case 0:
        return 'assets/Images/bay.jpg';
      case 1:
        return 'assets/Images/puypuy.jpg';
      case 2:
        return 'assets/Images/masaya.jpg';
      case 3:
        return 'assets/Images/cmdi.jpg';
      case 4:
        return 'assets/Images/bitin.jpg';
      default:
        return 'assets/Images/bay.jpg';
    }
  }
}
