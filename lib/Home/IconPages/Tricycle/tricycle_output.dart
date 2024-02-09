import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _db = FirebaseFirestore.instance;
final CollectionReference tricycleInfo =
    FirebaseFirestore.instance.collection('tricycle_info');
final FirebaseAuth _auth = FirebaseAuth.instance;
final User? currentUser = _auth.currentUser;
final String driverId = currentUser?.phoneNumber ?? "";

class TricycleDetailsScreen extends StatefulWidget {
  const TricycleDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TricycleDetailsScreen> createState() => _TricycleDetailsScreenState();
}

class _TricycleDetailsScreenState extends State<TricycleDetailsScreen> {
  late List<Map<String, dynamic>> TricycleOutput = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTricycleInformation();
  }

  Future<void> fetchTricycleInformation() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await tricycleInfo
          .where('uid', isEqualTo: driverId)
          .get() as QuerySnapshot<Map<String, dynamic>>;

      setState(() {
        TricycleOutput = querySnapshot.docs.map((doc) => doc.data()).toList();
        isLoading = false;
      });
    } catch (error) {
      print("Error fetching data: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tricycle Information'),
      ),
      body: GestureDetector(
        onTap: () {},
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.green],
              ),
            ),
            padding: EdgeInsets.all(16.0),
            child: Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Driver's Details",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text("Tricycle"),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        height: 200.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 3.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(2, 2),
                              blurRadius: 2,
                            ),
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(-2, -2),
                              blurRadius: 2,
                            ),
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 0),
                              blurRadius: 4,
                            ),
                          ],
                          image: TricycleOutput.isNotEmpty &&
                                  TricycleOutput[0]['tricyclePhoto'] != null
                              ? DecorationImage(
                                  image: NetworkImage(
                                    TricycleOutput[0]['tricyclePhoto']!,
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: AssetImage('assets/image1.png'),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    buildTextFormFieldWithIcon(
                      labelText: "Driver's License No.",
                      icon: Icons.assignment_ind,
                      defaultText: TricycleOutput.isNotEmpty
                          ? TricycleOutput[0]['licenseNo']
                          : 'License No.',
                      enabled: false,
                    ),
                    buildTextFormFieldWithIcon(
                      labelText: 'Years of Driving',
                      icon: Icons.timeline,
                      defaultText: TricycleOutput.isNotEmpty
                          ? TricycleOutput[0]['yearsOfDriving']
                          : 'Years of driving',
                      enabled: false,
                    ),
                    buildTextFormFieldWithIcon(
                      labelText: 'License Class',
                      icon: Icons.card_membership,
                      defaultText: TricycleOutput.isNotEmpty
                          ? TricycleOutput[0]['licenseClass']
                          : 'License Class',
                      enabled: false,
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'Tricycle Information',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    buildTextFormFieldWithIcon(
                      labelText: 'Vehicle Brand',
                      icon: Icons.directions_car,
                      defaultText: TricycleOutput.isNotEmpty
                          ? TricycleOutput[0]['brand']
                          : 'Brand',
                      enabled: false,
                    ),
                    buildTextFormFieldWithIcon(
                      labelText: 'Vehicle Model',
                      icon: Icons.directions_car,
                      defaultText: TricycleOutput.isNotEmpty
                          ? TricycleOutput[0]['model']
                          : 'Model',
                      enabled: false,
                    ),
                    buildTextFormFieldWithIcon(
                      labelText: 'Plate No',
                      icon: Icons.confirmation_number,
                      defaultText: TricycleOutput.isNotEmpty
                          ? TricycleOutput[0]['plateNo']
                          : 'Plate Number',
                      enabled: false,
                    ),
                    buildTextFormFieldWithIcon(
                      labelText: 'Engine No',
                      icon: Icons.engineering,
                      defaultText: TricycleOutput.isNotEmpty
                          ? TricycleOutput[0]['engineNo']
                          : 'Engine Number',
                      enabled: false,
                    ),
                    buildTextFormFieldWithIcon(
                      labelText: 'Chassis Number',
                      icon: Icons.format_list_numbered,
                      defaultText: TricycleOutput.isNotEmpty
                          ? TricycleOutput[0]['chassisNo']
                          : 'Chassis Number',
                      enabled: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormFieldWithIcon({
    required String labelText,
    required IconData icon,
    String? subtext,
    String? defaultText,
    bool enabled = true,
  }) {
    TextEditingController controller = TextEditingController(text: defaultText);

    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText,
        icon: Icon(icon),
        helperText: subtext,
      ),
    );
  }
}
