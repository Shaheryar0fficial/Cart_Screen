import 'package:cart_screen/cart_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(TeleHealthApp());
}

class TeleHealthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tele Health App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto', // Ensure this matches the Figma design
      ),
      home: CartScreen(),
    );
  }
}
