import 'package:flutter/material.dart';

class PickupLocationModal extends StatelessWidget {
  final Function(String) onPickupLocationSelected;
  final Map<String, dynamic> selectedPickupLocation; // Add this line

  const PickupLocationModal({
    Key? key,
    required this.onPickupLocationSelected,
    required this.selectedPickupLocation, // Add this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> pickupLocation =
        selectedPickupLocation; // Define a variable to hold pickup location

    return Container(
      height: MediaQuery.of(context).size.height *
          0.4, // Adjust the height as needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Pass pickup location to the callback function
                print("Pickup location is: $selectedPickupLocation");
                Navigator.pop(context); // Close the bottom sheet
              },
              child: Text('Find'),
            ),
          ),
        ],
      ),
    );
  }
}
