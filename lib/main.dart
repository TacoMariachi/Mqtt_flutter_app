import 'package:flutter/material.dart';
import 'package:finalprojectapp/Screens/Mqtt_initialize.dart';
import 'package:finalprojectapp/Wrappers/App_wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: AppWrapper()
    );
  }
}
