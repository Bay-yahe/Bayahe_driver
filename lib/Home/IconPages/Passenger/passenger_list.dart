import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Booking/bookingscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final _db = FirebaseFirestore.instance;
final CollectionReference bookingDetails =
    FirebaseFirestore.instance.collection('booking_details');
final FirebaseAuth _auth = FirebaseAuth.instance;
final User? currentUser = _auth.currentUser;
final String driverId = currentUser?.phoneNumber ?? "";

final String status = "pending";
final String updateStatus = "accepted";

class Passenger extends StatefulWidget {
  const Passenger({Key? key}) : super(key: key);

  @override
  State<Passenger> createState() => _Passenger();
}

class _Passenger extends State<Passenger> {
  late List<Map<String, dynamic>> bookingHistory;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBookingHistory();
  }

  void fetchBookingHistory() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await bookingDetails
          .where('status', isEqualTo: status)
          .get() as QuerySnapshot<Map<String, dynamic>>;

      setState(() {
        bookingHistory = querySnapshot.docs.map((doc) => doc.data()).toList();
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
        title: const Text('Booking History'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.3, -0.3),
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.green],
          ),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : bookingHistory.isEmpty
                ? Center(child: Text('No booking history available'))
                : ListView.builder(
                    itemCount: bookingHistory.length,
                    itemBuilder: (context, index) {
                      final data = bookingHistory[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: ListTile(
                          title: Text(
                            'Travel: ${data['pickupLocation'] ?? 'N/A'} - ${data['destination'] ?? 'N/A'}',
                          ),
                          subtitle: Text(formatTimestamp(data['bookingTime'])),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingDetailsScreen(
                                  bookingData: data,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  String formatTimestamp(Timestamp timestamp) {
    final philippinesTime = timestamp.toDate().add(const Duration(hours: 8));
    final formatter = DateFormat.yMMMMd().add_jm();
    return formatter.format(philippinesTime);
  }
}

class BookingDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> bookingData;

  const BookingDetailsScreen({Key? key, required this.bookingData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String transactionId = bookingData['transactionID'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF33c072),
        title: const Text('Booking Details'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.3, -0.3),
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.green],
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BookingDetailItem(
                      label: 'Date & Time',
                      value: formatTimestamp(bookingData['bookingTime']),
                    ),
                    BookingDetailItem(
                      label: 'Passenger',
                      value: bookingData['contactPerson'],
                    ),
                    BookingDetailItem(
                      label: 'Contact',
                      value: bookingData['contactNumber'],
                    ),
                    BookingDetailItem(
                      label: 'Travel',
                      value:
                          '${bookingData['pickupLocation']} - ${bookingData['destination']}',
                    ),
                    BookingDetailItem(
                      label: 'Fare',
                      value: bookingData['fareType'],
                    ),
                    BookingDetailItem(
                      label: 'Type',
                      value: '${bookingData['passengerType']} passenger',
                    ),
                    BookingDetailItem(
                      label: 'Mode of Payment',
                      value: bookingData['paymentMethod'],
                    ),
                    BookingDetailItem(
                      label: 'Reference Number',
                      value: bookingData['transactionID'],
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await _db
                              .collection("booking_details")
                              .where("transactionID", isEqualTo: transactionId)
                              .get()
                              .then(
                            (querySnapshot) {
                              for (var doc in querySnapshot.docs) {
                                doc.reference.update({
                                  'status': updateStatus,
                                  'driverId': driverId,
                                });
                              }
                            },
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingTab(),
                            ),
                          );
                        },
                        child: Text('Accept'),
                      ),
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

  String formatTimestamp(Timestamp timestamp) {
    final philippinesTime = timestamp.toDate().add(const Duration(hours: 8));
    final formatter = DateFormat.yMMMMd().add_jm();
    return formatter.format(philippinesTime);
  }
}

class BookingDetailItem extends StatelessWidget {
  final String label;
  final String value;

  const BookingDetailItem({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
