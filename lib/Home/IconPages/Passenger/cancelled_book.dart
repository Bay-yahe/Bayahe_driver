import 'package:flutter/material.dart';

class Cancel extends StatelessWidget {
  const Cancel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Cancelled",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red, // Customize the color if needed
        ),
        body: CancelledList(),
      ),
    );
  }
}

class CancelledList extends StatelessWidget {
  final List<Map<String, String>> cancellations = [
    {"name": "John Doe", "date": "2023-12-01", "time": "10:00 AM"},
    {"name": "Jane Doe", "date": "2023-12-02", "time": "02:30 PM"},
    {"name": "Alice Smith", "date": "2023-12-03", "time": "05:45 PM"},
    // Add more entries as needed
  ];

  CancelledList({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.symmetric(
          inside: BorderSide.none, outside: BorderSide.none),
      columnWidths: const {
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
      },
      children: [
        const TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    Text("Time", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        for (var cancellation in cancellations)
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(cancellation['name']!),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(cancellation['date']!),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(cancellation['time']!),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
