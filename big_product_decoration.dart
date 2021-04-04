import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class BigProductDecoration extends StatefulWidget {
  int expectedPrice;
  int index;
  dynamic chatDocs;
  File image;
  String name;
  String phoneNo;
  String userUid;
  BigProductDecoration(this.expectedPrice, this.index, this.chatDocs,
      this.image, this.name, this.phoneNo, this.userUid);
  @override
  _BigProductDecorationState createState() => _BigProductDecorationState();
}

class _BigProductDecorationState extends State<BigProductDecoration> {
  String _textFromFile = "";
  String filePath = "";
  String picId = "";
  String finalId = "";
  _BigProductDecorationState() {
    // very important if u wana change Future<String> into String
    sendMessage().then((val) => setState(() {
          _textFromFile = val;
          if (_textFromFile == widget.userUid) {
            finalId = "";
          } else {
            DocumentReference usersRef = Firestore.instance
                .collection('SellerBuyerChat')
                .document(_textFromFile + widget.userUid);
            usersRef.get().then((docSnapshot) => {
                  if (docSnapshot.exists)
                    finalId = _textFromFile + widget.userUid
                  else
                    finalId =
                        widget.userUid + _textFromFile // create the document
                });
          }
        }
        ));
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

  // Future<String> _getId() async{
  //   DocumentReference usersRef =  Firestore.instance
  //       .collection('users')
  //       .document(_textFromFile + widget.userUid);
  //   String ansId = '';
  //   await usersRef.get().then((docSnapshot) => {
  //         if (docSnapshot.exists)
  //           {ansId = _textFromFile + widget.userUid}
  //         else
  //           {
  //             ansId = widget.userUid + _textFromFile // create the document
  //           }
  //       });
  //   print(ansId);
  //   return ansId;
  // }

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
                  InkWell(
                    splashColor: Colors.blue,
                    onTap: () {
                      Navigator.of(context).pushNamed('/OrderPlacedScreen',
                          arguments: widget.chatDocs[widget.index]);
                      // Firestore.instance
                      //     .collection("userProductsData")
                      //     .document(widget.chatDocs[widget.index].documentID)
                      //     .delete()
                      //     .catchError((e) {
                      //   print(e);
                      // });
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.shopping_cart),
                        SizedBox(
                          width: 6,
                        ),
                        Text('Buy'),
                      ],
                    ),
                  ),
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
                    splashColor: Colors.blue,
                    onTap: () => Navigator.of(context)
                        .pushNamed('/ChatScreen', arguments: finalId),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.chat,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text('Chat with Seller'),
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

  // String _getId() {
  //   DocumentReference usersRef = Firestore.instance
  //       .collection('SellerBuyerChat')
  //       .document(_textFromFile + widget.userUid);
  //   String ansId = '';
  //   usersRef.get().then((docSnapshot) => {
  //         if (docSnapshot.exists)
  //           ansId = _textFromFile + widget.userUid
  //         else
  //           ansId = widget.userUid + _textFromFile // create the document
  //       });
  //   print(ansId);
  //   return ansId;
  // }
}
