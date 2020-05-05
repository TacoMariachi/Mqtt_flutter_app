import 'package:finalprojectapp/Providers/Message_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalprojectapp/Shared/Templates.dart';
import 'package:flutter/foundation.dart';
import 'package:finalprojectapp/Services/Mqtt_manager.dart';
import 'package:finalprojectapp/Providers/Message_provider.dart';
import 'package:finalprojectapp/Providers/Client_provider.dart';

class MQTTPublish extends StatefulWidget {
  @override
  _MQTTPublishState createState() => _MQTTPublishState();
}

class _MQTTPublishState extends State<MQTTPublish> {
  final _formKey = GlobalKey<FormState>();
  String topic = '';
  String variable = '';
  String value = '';
  String message = '';
  String error;

  @override
  Widget build(BuildContext context) {
    final MQTTManager managerProvider = Provider.of<MQTTManager>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            TextFormField(
              decoration: textInputTemplate.copyWith(hintText: 'Topic'),
              validator: (val) => val.isEmpty ? 'Enter a valid topic': null,
              onChanged: (val) {
                setState(() => topic = val);
              },
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: textInputTemplate.copyWith(hintText: 'Variable'),
              validator: (val) => val.isEmpty ? 'Enter a valid variable': null,
              onChanged: (val) {
                setState(() => variable = val);
              },
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: textInputTemplate.copyWith(hintText: 'Value'),
              validator: (val) => val.isEmpty ? 'Enter a valid value': null,
              onChanged: (val) {
                setState(() => value = val);
              },
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              onPressed: () async {
                if(_formKey.currentState.validate()){
                  setState(() {
                    topic = '/v1.6/devices/' + topic;
                    message = '{"$variable" : $value}';
                    managerProvider.publish(topic: topic, message: message);
                  });
                }
              },
              color: Colors.pink[900],
              child: Text(
                'Publish',
                style: TextStyle(
                  color: Colors.pink[100],
                  fontSize: 15.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Consumer<MQTTMessageProvider>(
              builder: (context, messageProvider, child){
                return SingleChildScrollView(
                  child: Text(
                      messageProvider.message
                  ),
                );
              },
            ),
            SizedBox(height: 10.0),
            Text(managerProvider.client.subscriptionsManager.subscriptions.toString()),
          ],
        ),
      ),
    );
  }
}
