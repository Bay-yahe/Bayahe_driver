import 'package:flutter/material.dart';

class BottomScreen extends StatelessWidget {
  const BottomScreen({super.key, Key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      right: 16,
      child: IconButton(
        onPressed: () {
          _showBottomSheet(context);
        },
        icon: const Icon(
          Icons.more_vert,
          color: Colors.green, // Set your preferred color
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builderContext) {
        return Card(
          elevation: 5,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Ongoing',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date: 2023-11-29', // Replace with actual date
                    ),
                    Text(
                      'Time: 14:30', // Replace with actual time
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('From'),
                const TextField(
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    labelText: 'From',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('To'),
                const TextField(
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    labelText: 'To',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Fare Price'),
                const TextField(
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    labelText: 'Fare Price',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Payment Method'),
                DropdownButton<String>(
                  items: ['In-Cash', 'G-Cash', 'Paymaya'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    // Handle the selected payment method
                  },
                  value: 'In-Cash', // Set the default value
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Add your logic for the "Arrived" button
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue, // Set your preferred button color
                  ),
                  child: const Text(
                    'Arrived',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
