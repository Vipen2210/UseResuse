import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderPlacedScreen extends StatefulWidget {
  DocumentSnapshot chatdocs;
  OrderPlacedScreen(this.chatdocs);
  @override
  _OrderPlacedScreenState createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oder placed'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Center(
          child: Container(
            child: Column(
              children: [
                Icon(Icons.done_all),
                RaisedButton(
                  onPressed: () {
                    Firestore.instance
                        .collection("userProductsData")
                        .document(widget.chatdocs.documentID)
                        .delete()
                        .catchError((e) {
                      print(e);
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Done!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
