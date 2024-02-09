import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver/components/chat_bubble.dart';
import 'package:driver/components/textfield.dart';
import 'package:driver/provider/chat/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String passengerUserID;

  const ChatPage({
    super.key, // Add Key? key parameter

    required this.passengerUserID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    // only send message if there is something to send
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.passengerUserID, _messageController.text);
      //clear the text controller after sending the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.passengerUserID),
      ),
      body: Center(
        // You can add your chat UI components here
        child: Column(
          children: [
            //messages
            Expanded(
              child: _buildMessageList(),
            ),

            // user input
            _buildMessageInput(),

            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  // build meesage list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(widget.passengerUserID,
          _firebaseAuth.currentUser!.phoneNumber as String),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // align the message to the right if the sender is the current user, other to the left
    var alignment =
        (data['receiverId'] == _firebaseAuth.currentUser!.phoneNumber)
            ? Alignment.centerRight
            : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['receiverId'] == _firebaseAuth.currentUser!.phoneNumber)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['receiverId'] == _firebaseAuth.currentUser!.phoneNumber)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            Text(data['receiverId']),
            ChatBubble(message: data['message']),
          ],
        ),
      ),
    );
  }

  // build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          // textfield
          Expanded(
            child: MyTextField(
                controller: _messageController,
                hintText: 'Enter a Message',
                obscureText: false),
          ),

          // send button
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.arrow_upward,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
