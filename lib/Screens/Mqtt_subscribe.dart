import 'package:finalprojectapp/Providers/Client_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalprojectapp/Shared/Templates.dart';
import 'package:finalprojectapp/Services/Mqtt_manager.dart';


class MQTTSubscribe extends StatefulWidget {
  @override
  _MQTTSubscribeState createState() => _MQTTSubscribeState();
}

class _MQTTSubscribeState extends State<MQTTSubscribe> {
  final _formKey = GlobalKey<FormState>();
  MQTTManager manager = MQTTManager();
  String topic = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    //final manager = Provider.of<MQTTManager>(context, listen: false);
    return SafeArea(
      child: Container(
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
              Consumer<MQTTManager>(
                builder: (context, managerProvider, child){
                  //manager.client = clientProvider.client;
                  //print('Por la putisima madre ${manager.client}');
                  return RaisedButton(
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        setState(() {
                          topic = '/v1.6/devices/' + topic;
                          managerProvider.subscription(topic: topic);
                        });
                      }else{
                        error='idk wtf man';
                      }
                    },
                    color: Colors.pink[900],
                    child: Text(
                      'Subscription to topics',
                      style: TextStyle(
                        color: Colors.pink[100],
                        fontSize: 15.0,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 10.0),
              Text(error),
            ],
          ),
        ),
      ),
    );
  }
}

