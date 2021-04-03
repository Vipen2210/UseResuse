import 'package:dukan_app/route/route_generator.dart';
import 'package:dukan_app/screens/auth_screen.dart';
import 'package:dukan_app/screens/medId_screen.dart';
import 'package:dukan_app/screens_sell_buy/sell_screen.dart';
import 'package:dukan_app/screens_sell_buy/tab_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Future<String> _sendMessage() async {
    //   final user = await FirebaseAuth.instance.currentUser();
    //   return user.uid;
    // }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        backgroundColor: Colors.red[100],
        accentColor: Colors.deepPurple[300],
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.deepOrange[400],
          textTheme: ButtonTextTheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      // initialRoute: '/MedIdScreen',   // becuase its pushing unwanted screen on the flutter base
      onGenerateRoute: RouteGenerator.generateRoute,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return TabsScreen();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
