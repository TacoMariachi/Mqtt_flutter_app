import 'package:finalprojectapp/Services/Mqtt_manager.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectapp/Screens/Mqtt_initialize.dart';
import 'package:provider/provider.dart';
import 'package:finalprojectapp/Providers/Message_provider.dart';
import 'package:finalprojectapp/Providers/Client_provider.dart';

class AppWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MQTTMessageProvider>(
          create: (_) => MQTTMessageProvider(),
        ),
        ChangeNotifierProvider<MQTTManager>(
          create: (_) => MQTTManager(),
        ),
      ],
      child: MQTTInitialize()
    );
  }
}
