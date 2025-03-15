import 'package:flutter/material.dart';
import 'emissions_calculator.dart';

void main() {
  runApp(const EmissionsCalculatorApp());
}

class EmissionsCalculatorApp extends StatelessWidget {
  const EmissionsCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Greena',
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light,
        fontFamily: 'Roboto',
      ),
      home: const EmissionsCalculator(),
    );
  }
}