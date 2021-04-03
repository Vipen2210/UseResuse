import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukan_app/widgets/sell/product_decoration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  String _textFromFile = '';
  _AllProductsState() {
    // very important if u wana change Future<String> into String
    sendMessage().then((val) => setState(() {
          _textFromFile = val;
        }));
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return StreamBuilder(
            stream: Firestore.instance
                .collection("userProductsData")
                .document(_textFromFile)
                .collection("Products")
                .orderBy(
                  'createdAt',
                )
                .snapshots(),
            builder: (context, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = chatSnapshot.data.documents;

              return ListView.builder(
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) => ProductDecoration(
                  chatDocs[index]['expectedPrice'],
                  index,
                  chatDocs,
                  chatDocs[index]['image'],
                  chatDocs[index]['name'],chatDocs[index]['phoneNo'],
                ),
              );
            });
      },
    );
  }

  Future<String> sendMessage() async {
    final user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }
}
