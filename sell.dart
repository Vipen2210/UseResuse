import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukan_app/widgets/image/image_capture.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Sell extends StatefulWidget {
  @override
  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> {
  var _enteredName = '';
  var _enteredPhoneNo = '';
  var _enteredRollNo = '';
  var _enteredHostel = '';
  var _enteredExpectedPrice = 0;
  final myControllerName = TextEditingController();
  final myControllerPhoneNo = TextEditingController();
  final myControllerRollNo = TextEditingController();
  final myControllerHostel = TextEditingController();
  final myControllerExpectedPrice = TextEditingController();
  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    Firestore.instance
        .collection("userProductsData")
        .document(user.uid)
        .collection("Products")
        .add({
      'name': _enteredName,
      'phoneNo': _enteredPhoneNo,
      'rollNo': _enteredRollNo,
      'createdAt': Timestamp.now(),
      'hostel': _enteredHostel,
      'userId': user.uid,
      'expectedPrice': _enteredExpectedPrice,
    });
    Firestore.instance.collection("userProductsData").add({
      'name': _enteredName,
      'phoneNo': _enteredPhoneNo,
      'rollNo': _enteredRollNo,
      'createdAt': Timestamp.now(),
      'hostel': _enteredHostel,
      'userId': user.uid,
      'expectedPrice': _enteredExpectedPrice,
    });
    Navigator.of(context).pushReplacementNamed('/TabsScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product details'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/TabsScreen');
              }),
        ],
      ),
      body: Card(
        margin: EdgeInsets.all(12.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://media.springernature.com/m685/springer-static/image/art%3A10.1038%2Fs41393-019-0246-8/MediaObjects/41393_2019_246_Fig1_HTML.png'),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: TextField(
                    controller: myControllerName,
                    decoration: InputDecoration(
                      labelText: "Product name",
                      labelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                    ),
                    // onChanged:
                    onChanged: (value) {
                      setState(() {
                        _enteredName = value;
                      });
                    }),
              ),
              Expanded(
                child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: myControllerPhoneNo,
                    decoration: InputDecoration(
                      labelText: 'Contact no',
                      labelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                    ),
                    // onChanged:
                    onChanged: (value) {
                      setState(() {
                        _enteredPhoneNo = value;
                      });
                    }),
              ),
              Expanded(
                child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: myControllerRollNo,
                    decoration: InputDecoration(
                      labelText: 'Roll No',
                      labelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                    ),
                    // onChanged:
                    onChanged: (value) {
                      setState(() {
                        _enteredRollNo = value;
                      });
                    }),
              ),
              Expanded(
                child: TextField(
                    controller: myControllerHostel,
                    decoration: InputDecoration(
                      labelText: 'Hostel',
                      labelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                    ),
                    // onChanged:
                    onChanged: (value) {
                      setState(() {
                        _enteredHostel = value;
                      });
                    }),
              ),
              Expanded(
                child: TextField(
                    controller: myControllerExpectedPrice,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Expected Price',
                      labelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                    ),
                    // onChanged:
                    onChanged: (value) {
                      setState(() {
                        _enteredExpectedPrice = int.parse(value);
                      });
                    }),
              ),
              Expanded(
                  child: RaisedButton(
                onPressed: () => Navigator.of(context).pushNamed(
                    "/ImageCapture",
                    arguments: _enteredName + _enteredPhoneNo),
                child: Icon(Icons.camera_alt),
              )),
              RaisedButton(
                onPressed: _sendMessage,
                child: Text(
                  'Create',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                color: Colors.green,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
