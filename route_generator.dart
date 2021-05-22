import 'package:dukan_app/screens/chat_screen.dart';
import 'package:dukan_app/screens/order_placed_screen.dart';
import 'package:dukan_app/screens/tab_screen.dart';
import 'package:dukan_app/widgets/image/image_capture.dart';
import 'package:dukan_app/widgets/sell/sell.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // getting all aguments passed during Navigator.pushnamed.
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => TabsScreen());
      case '/TabsScreen':
        return MaterialPageRoute(builder: (_) => TabsScreen());
      case '/Sell':
        return MaterialPageRoute(builder: (_) => Sell());
      case '/ImageCapture':
        return MaterialPageRoute(builder: (_) => ImageCapture(args));
      case '/OrderPlacedScreen':
        return MaterialPageRoute(builder: (_) => OrderPlacedScreen(args));
      case '/ChatScreen':
        return MaterialPageRoute(builder: (_) => ChatScreen(args));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error!'),
        ),
        body: Center(
          child: Text('Error!'),
        ),
      );
    });
  }
}
