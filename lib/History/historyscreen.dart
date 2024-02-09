import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference bookingDetails =
    FirebaseFirestore.instance.collection('booking_details');
final FirebaseAuth _auth = FirebaseAuth.instance;
final User? currentUser = _auth.currentUser;
final String driverId = currentUser?.phoneNumber ?? "";
const String status1 = "done";
const String status2 = "cancelled";

class HistoryTab extends StatefulWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
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
              .where('driverId', isEqualTo: driverId)
              .where('status', whereIn: [status1, status2]).get()
          as QuerySnapshot<Map<String, dynamic>>;

      // Update the bookingHistory list with fetched data
      setState(() {
        bookingHistory = querySnapshot.docs.map((doc) => doc.data()).toList();
        isLoading = false; // Set isLoading to false when data is fetched
      });
    } catch (error) {
      print("Error fetching data: $error");
      isLoading = false; // Handle the error and set isLoading to false
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
            ? Center(
                child: CircularProgressIndicator()) // Show loading indicator
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
                        onPressed: () {
                          // Implement the logic to start a chat with the driver
                          // You can use Navigator to navigate to the chat screen
                          // For example, Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDriverScreen()));
                        },
                        child: Text('Chat Passenger'),
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
