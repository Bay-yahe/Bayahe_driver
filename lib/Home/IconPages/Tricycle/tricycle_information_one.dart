import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Home/IconPages/Tricycle/tricycle_information_two.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TricycleInformationOne extends StatefulWidget {
  const TricycleInformationOne({Key? key}) : super(key: key);

  @override
  _TricycleInformationOneState createState() => _TricycleInformationOneState();
}

class _TricycleInformationOneState extends State<TricycleInformationOne> {
  TextEditingController licenseNoController = TextEditingController();
  TextEditingController yearsOfDrivingController = TextEditingController();
  TextEditingController licenseClassController = TextEditingController();

  TextEditingController engineNoController = TextEditingController();
  TextEditingController chassisNoController = TextEditingController();

  File? licenseImageFile;
  File? receiptImageFile;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('tricycle_info');

  bool isLoading = false;
  late String user;
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    user = _firebaseAuth.currentUser?.phoneNumber ?? '';
  }

  bool isDataIncomplete() {
    return licenseNoController.text.isEmpty ||
        yearsOfDrivingController.text.isEmpty ||
        licenseClassController.text.isEmpty ||
        engineNoController.text.isEmpty ||
        chassisNoController.text.isEmpty ||
        licenseImageFile == null ||
        receiptImageFile == null;
  }

  Future<String?> uploadImage(File? imageFile, String imageName) async {
    try {
      if (imageFile == null) return null;

      final Reference storageReference =
          FirebaseStorage.instance.ref().child(imageName).child(user);

      final UploadTask uploadTask = storageReference.putFile(imageFile);
      await uploadTask.whenComplete(() => null);

      return await storageReference.getDownloadURL();
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> uploadData() async {
    setState(() {
      isLoading = true;
    });

    String? licenseImageUrl = await uploadImage(licenseImageFile, 'licensePic');
    String? receiptImageUrl = await uploadImage(receiptImageFile, 'receiptPic');

    final Map<String, dynamic> newData = {
      'licenseNo': licenseNoController.text,
      'yearsOfDriving': yearsOfDrivingController.text,
      'licenseClass': licenseClassController.text,
      'engineNo': engineNoController.text,
      'chassisNo': chassisNoController.text,
      'licensePic': licenseImageUrl,
      'receiptPic': receiptImageUrl,
      'uid': user,
    };

    await _db.collection("tricycle_info").add(newData);

    setState(() {
      isLoading = false;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TricycleInformationTwo()),
    );
  }

  Future<void> showImagePicker(bool isLicenseImage) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          if (isLicenseImage) {
            licenseImageFile = File(pickedFile.path);
          } else {
            receiptImageFile = File(pickedFile.path);
          }
        });
      }
    } catch (e) {
      print("Error picking an image: $e");
    }
  }

  Widget buildImagePreview(File? imageFile) {
    return imageFile != null
        ? Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(imageFile),
              ),
            ),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.green],
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                const Text(
                  "Hello, Driver!",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                const Text("Please provide the following information"),
                const SizedBox(height: 20.0),
                Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.credit_card,
                                color: Color.fromARGB(255, 52, 4, 228)),
                            const SizedBox(width: 8.0),
                            const Text(
                              "Driver's License",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                showImagePicker(true);
                              },
                              child: const Text("Upload"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        buildImagePreview(licenseImageFile),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: licenseNoController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.card_membership),
                            labelText: "Driver's License No.",
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: yearsOfDrivingController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.calendar_today),
                            labelText: "Years of Driving",
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: licenseClassController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.drive_eta),
                            labelText: "License Class",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.receipt,
                                color: Color.fromARGB(255, 22, 163, 29)),
                            const SizedBox(width: 8.0),
                            const Text(
                              "Certificate of Receipt",
                              style: TextStyle(fontSize: 15.0),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                showImagePicker(false);
                              },
                              child: const Text("Upload"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        buildImagePreview(receiptImageFile),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: engineNoController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.e_mobiledata_outlined),
                            labelText: "Engine No.",
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: chassisNoController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.motorcycle_sharp),
                            labelText: "Chassis No.",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: uploadData,
                    child: isLoading
                        ? const CircularProgressIndicator() // Show a loading indicator
                        : const Text("Next"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
