import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/Chat/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatHomepage extends StatefulWidget {
  const ChatHomepage({Key? key});

  @override
  State<ChatHomepage> createState() => _ChatHomepageState();
}

class _ChatHomepageState extends State<ChatHomepage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: _buildUserList(_auth, context),
    );
  }

  Widget _buildUserList(FirebaseAuth auth, BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat_rooms')
          .where('receiverId', isEqualTo: auth.currentUser?.phoneNumber)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Loading...'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No Previous Chat.'));
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc, auth, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      DocumentSnapshot document, FirebaseAuth auth, BuildContext context) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

    if (data != null &&
        auth.currentUser != null &&
        data['senderId'] != null &&
        auth.currentUser!.uid != (data['senderId'] as String)) {
      return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('client_user')
            .where('userId', isEqualTo: data['senderId'])
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListTile(
              title: Text('Loading...'),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return ListTile(
              title: Text('Client not found'),
            );
          }

          var clientUser =
              snapshot.data!.docs.first.data() as Map<String, dynamic>?;

          if (clientUser == null) {
            return ListTile(
              title: Text('Client not found'),
            );
          }

          return ListTile(
            title: Text(
              '${clientUser['firstname']} ${clientUser['lastname']}',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    passengerUserID: data['senderId'] as String,
                  ),
                ),
              );
            },
          );
        },
      );
    } else {
      return Container();
    }
  }
}
