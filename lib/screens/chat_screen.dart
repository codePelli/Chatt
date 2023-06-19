import 'package:chaat/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String messageText = '';
  late User loggedUser;
  final messageTextController = TextEditingController();

  void getCurrentUser() async {
    await Firebase.initializeApp();
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void messagesStream() async {
    await for (var snapshot in _firestore
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                messagesStream();
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chatt'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                List<MessageWindow> messageWindow = [];
                if (snapshot.hasData) {
                  final messages = snapshot.data?.docs;
                  for (var message in messages!) {
                    final messageText = message.get('text');
                    final messageSender = message.get('sender');
                    messageWindow.add(MessageWindow(
                        sender: messageSender, text: messageText));
                  }
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    children: messageWindow,
                  ),
                );
              },
            ),
            Container(
              decoration: kInputContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        setState(() {
                          messageTextController.text = value;
                        });
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: ElevatedButton(
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        _firestore.collection('messages').add({
                          'text': messageTextController.text,
                          'sender': loggedUser.email,
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                        setState(() {
                          messageTextController.clear();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageWindow extends StatelessWidget {
  final String sender;
  final String text;

  MessageWindow({required this.sender, required this.text});

  final _loggedInUser = FirebaseAuth.instance.currentUser;

  Color _getBackgroundColor() {
    if (sender == _loggedInUser?.email) {
      return Colors.lightBlueAccent;
    } else {
      return Colors.white;
    }
  }

  Color _getTextColor() {
    if (sender == _loggedInUser?.email) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
                sender,
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.black,
            )),
        Material(
          borderRadius: BorderRadius.circular(30.0),
          elevation: 5.0,
          color: _getBackgroundColor(),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20.0,
                color: _getTextColor(),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
