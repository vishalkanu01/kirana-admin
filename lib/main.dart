import 'package:kiranaadminapp/notifier/food_notifier.dart';
import 'package:kiranaadminapp/screens/admin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notifier/auth_notifier.dart';
import 'notifier/order_notifier.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => FoodNotifier(),
        ),
        ChangeNotifierProvider(
          builder: (context) => OrderNotifier(),
        ),
        ChangeNotifierProvider(
          builder: (context) => AuthNotifier(),
        ),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.lightBlue,
        ),
        home: Admin());
  }
}
