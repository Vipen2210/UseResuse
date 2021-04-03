import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dukan_app/widgets/sell/all_products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuyScreen extends StatefulWidget {
  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(child: AllProducts()),
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/Sell');
              },
              child: const Text('Add product!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              color: Colors.black,
              textColor: Colors.white,
              elevation: 5,
            ),
          ),
        ],
      ),
    );
  }
}
