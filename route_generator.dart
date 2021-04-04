import 'package:dukan_app/screens/chat_screen.dart';
import 'package:dukan_app/screens/detail_screen.dart';
import 'package:dukan_app/screens/khata_screen.dart';
import 'package:dukan_app/screens/medDetail_screen.dart';
import 'package:dukan_app/screens/medId_screen.dart';
import 'package:dukan_app/screens_sell_buy/buy_screen.dart';
import 'package:dukan_app/screens_sell_buy/order_placed_screen.dart';
import 'package:dukan_app/screens_sell_buy/sell_screen.dart';
import 'package:dukan_app/screens_sell_buy/tab_screen.dart';
import 'package:dukan_app/widgets/image/image_capture.dart';
import 'package:dukan_app/widgets/khata/add_detail.dart';
import 'package:dukan_app/widgets/khata/add_khata.dart';
import 'package:dukan_app/widgets/med/addMed_detail.dart';
import 'package:dukan_app/widgets/med/create_id.dart';
import 'package:dukan_app/widgets/sell/sell.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // getting all aguments passed during Navigator.pushnamed.
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => KhataScreen());
      case '/AddKhata':
        return MaterialPageRoute(builder: (_) => AddKhata());
      case '/DetailScreen':
        return MaterialPageRoute(builder: (_) => DetailScreen(args));
      case '/AddDetail':
        return MaterialPageRoute(builder: (_) => AddDetail(args));
      case '/MedIdScreen':
        return MaterialPageRoute(builder: (_) => MedIdScreen());
      case '/CreateId':
        return MaterialPageRoute(builder: (_) => CreateId());
      case '/MedDetailScreen':
        return MaterialPageRoute(builder: (_) => MedDetailScreen(args));
      case '/AddMedDetail':
        return MaterialPageRoute(builder: (_) => AddMedDetail(args));
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
