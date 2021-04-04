import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SellerDecoration extends StatefulWidget {
  int expectedPrice;
  int index;
  dynamic chatDocs;
  File image;
  String name;
  String phoneNo;
  SellerDecoration(this.expectedPrice, this.index, this.chatDocs, this.image,
      this.name, this.phoneNo);
  @override
  _SellerDecorationState createState() => _SellerDecorationState();
}

class _SellerDecorationState extends State<SellerDecoration> {
  String _textFromFile = "";
  String filePath = "";
  String picId = "";
  _SellerDecorationState() {
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    ans(),
                    height: 170,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.money,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text('Rs ${widget.expectedPrice}'),
                    ],
                  ),
                  InkWell(
                    onTap: () {
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
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.remove_circle_outline_rounded,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text('Remove Product'),
                      ],
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

  Future<String> sendMessage() async {
    final user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }
}
