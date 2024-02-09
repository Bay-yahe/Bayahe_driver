import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Report',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ReportScreen(),
    );
  }
}

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool showOthersTextField = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        backgroundColor: const Color(0xFF33c072),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.3, -0.3),
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.green],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reporter',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: 'Enter reporter name'),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(hintText: 'Enter date'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Time',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(hintText: 'Enter time'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Reason for Reporting',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            ActionButton(title: 'Abuse', onTap: () => _hideOthersTextField()),
                            ActionButton(title: 'Violence', onTap: () => _hideOthersTextField()),
                            ActionButton(title: 'Harassment', onTap: () => _hideOthersTextField()),
                            ActionButton(title: 'Over Pricing', onTap: () => _hideOthersTextField()),
                            ActionButton(
                              title: 'Others',
                              onTap: () => _toggleOthersTextField(),
                            ),
                          ],
                        ),
                        if (showOthersTextField) ...[
                          SizedBox(height: 10),
                          Text(
                            'Others',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            decoration: InputDecoration(hintText: 'Enter reason for others'),
                          ),
                        ],
                        SizedBox(height: 10),
                        Text(
                          'Statement',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          maxLines: 3,
                          decoration: InputDecoration(hintText: 'Enter your statement here'),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.send),
                          label: Text('Send'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            onPrimary: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleOthersTextField() {
    setState(() {
      showOthersTextField = !showOthersTextField;
    });
  }

  void _hideOthersTextField() {
    setState(() {
      showOthersTextField = false;
    });
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ActionButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(title),
      style: ElevatedButton.styleFrom(
        primary: Colors.blueGrey,
        onPrimary: Colors.white,
      ),
    );
  }
}
