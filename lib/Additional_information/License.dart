import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'License Verification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LicenseVerificationPage(),
    );
  }
}

class LicenseVerificationPage extends StatelessWidget {
  const LicenseVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('License Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  // Placeholder for the front driver license photo
                  Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Text(
                        'Front Driver License Photo',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  // Rectangle frame for scanning the front driver license
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Stack(
                children: [
                  // Placeholder for the back driver license photo
                  Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Text(
                        'Back Driver License Photo',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  // Rectangle frame for scanning the back driver license
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement your verification logic here
                print('Verify button clicked');
              },
              child: const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
