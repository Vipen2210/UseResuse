import 'package:dukan_app/widgets/chat/messages.dart';
import 'package:dukan_app/widgets/chat/new_messages.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  String userUid;
  ChatScreen(this.userUid);
  @override
  Widget build(BuildContext context) {
    return userUid.length == 0
        ? Scaffold(
            appBar: AppBar(
              title: Text('You are buyer'),
            ),
          )
        : Scaffold(
            // backgroundColor: Colors.brown[200],
            appBar: AppBar(
              title: Text('FlutterChat'),
            ),
            body: Container(
              child: Column(
                children: [
                  Expanded(child: Messages(userUid)),
                  NewMessage(userUid),
                ],
              ),
            ),
          );
  }
}
