import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Navbar/Navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class TricycleInformationTwo extends StatefulWidget {
  const TricycleInformationTwo({Key? key}) : super(key: key);

  @override
  _TricycleInformationTwoState createState() => _TricycleInformationTwoState();
}

class _TricycleInformationTwoState extends State<TricycleInformationTwo> {
  TextEditingController plateNoController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController todaController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();

  File? tricycleImageFile;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  late String user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    user = _firebaseAuth.currentUser?.phoneNumber ?? '';
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
                            const Icon(
                              Icons.credit_card,
                              color: Color.fromARGB(255, 0, 4, 255),
                            ),
                            const SizedBox(width: 8.0),
                            const Text(
                              "Tricycle",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                showImagePicker();
                              },
                              child: const Text("Upload"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        buildImagePreview(tricycleImageFile),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: brandController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.card_membership),
                            labelText: "Brand",
                          ),
                        ),
                        TextFormField(
                          controller: modelController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.card_membership),
                            labelText: "Model",
                          ),
                        ),
                        TextFormField(
                          controller: plateNoController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.card_membership),
                            labelText: "Plate No.",
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: colorController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.calendar_today),
                            labelText: "Color",
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: todaController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.drive_eta),
                            labelText: "TODA",
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
                    onPressed: () {
                      updateData();
                    },
                    child: const Text("Finish"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showImagePicker() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          tricycleImageFile = File(pickedFile.path);
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

  Future<String> uploadTricycleImage() async {
    if (tricycleImageFile == null) {
      return ''; // No image to upload
    }

    try {
      String fileName = user + "_tricycle_image.jpg";
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);

      await ref.putFile(tricycleImageFile!);
      String downloadURL = await ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print("Error uploading image: $e");
      return '';
    }
  }

  Future<void> updateData() async {
    setState(() {
      isLoading = true;
    });

    try {
      String tricycleImageURL = await uploadTricycleImage();

      await _db
          .collection("tricycle_info")
          .where("uid", isEqualTo: user)
          .get()
          .then(
        (querySnapshot) async {
          for (var doc in querySnapshot.docs) {
            await doc.reference.update({
              'plateNo': plateNoController.text,
              'color': colorController.text,
              'toda': todaController.text,
              'brand': brandController.text,
              'model': modelController.text,
              'tricyclePhoto': tricycleImageURL, // Add the image URL field
              // You can add other fields here based on your data model
            });
          }

          // Data updated successfully
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
      ).catchError((error) {
        print("Error updating data: $error");
        // Handle the error, e.g., show an error message
      }).whenComplete(() {
        setState(() {
          isLoading = false;
        });
      });
    } catch (e) {
      print("Error updating data with image URL: $e");
      // Handle the error, e.g., show an error message
      setState(() {
        isLoading = false;
      });
    }
  }
}
