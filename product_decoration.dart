import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProductDecoration extends StatefulWidget {
  int expectedPrice;
  int index;
  dynamic chatDocs;
  File image;
  String name;
  String phoneNo;
  ProductDecoration(this.expectedPrice, this.index, this.chatDocs, this.image,
      this.name, this.phoneNo);
  @override
  _ProductDecorationState createState() => _ProductDecorationState();
}

class _ProductDecorationState extends State<ProductDecoration> {
  String _textFromFile = "";
  String filePath = "";
  String picId = "";
  _ProductDecorationState() {
    // very important if u wana change Future<String> into String
    sendMessage().then((val) => setState(() {
          _textFromFile = val;
        }));
  }

  Future<String> getStorageUrl(String fileName) async {
    String url = "";
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("images/$fileName.png");
    url = await storageReference.getDownloadURL();
    print(url);
    return url;
  }

  void getImagePath() async {
    picId = widget.name + widget.phoneNo;
    print(picId);
    String path = await getStorageUrl(picId);
    setState(() {
      filePath = path;
    });
    print(filePath);
    print(picId);
  }

  String ans() {
    getImagePath();
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.red[900],
      highlightColor: Colors.deepPurpleAccent,
      // splashFactory: ,
      onTap: () {
        // Navigator.of(context)
        //     .pushNamed('/MedDetailScreen');
      },
      child: Card(
        child: ListTile(
          leading: Image.network(ans()),
          title: Text(
            widget.expectedPrice.toString(),
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Here we go',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Firestore.instance
                  .collection("userProductsData")
                  .document(_textFromFile)
                  .collection("Products")
                  .document(widget.chatDocs[widget.index].documentID)
                  .delete()
                  .catchError((e) {
                print(e);
              });
            },
          ),
          isThreeLine: true,
        ),
      ),
    );
  }

  Future<String> sendMessage() async {
    final user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }
}
