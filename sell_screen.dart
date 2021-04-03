import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukan_app/widgets/sell/product_decoration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SellScreen extends StatelessWidget {
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
                  chatDocs[index]['name'],
                  chatDocs[index]['phoneNo'],
                ),
              );
            });
      },
    );
  }
}
