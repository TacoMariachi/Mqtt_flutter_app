import 'package:finalprojectapp/Providers/Client_provider.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectapp/Services/Mqtt_manager.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:flutter/foundation.dart';
import 'package:finalprojectapp/Wrappers/Screens_wrapper.dart';
import 'package:finalprojectapp/Shared/Templates.dart';
import 'package:provider/provider.dart';


class MQTTInitialize extends StatefulWidget {
  @override
  _MQTTInitializeState createState() => _MQTTInitializeState();
}

class _MQTTInitializeState extends State<MQTTInitialize> {

  final _formKey = GlobalKey<FormState>();
  MQTTManager _manager = MQTTManager();
  MQTTClientProvider clientProvider;
  String host = '';
  String identifier = '';
  bool loading = false;
  String error = '';
  MqttConnectionState patata = MqttConnectionState.disconnected;

  @override
  Widget build(BuildContext context) {
    return patata == MqttConnectionState.connected ? ScreensWrapper() :SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 0.0,
          title: Text(
            'Mqtt app',
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.white
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputTemplate.copyWith(hintText: 'Host'),
                  validator: (val) => val.isEmpty ? 'Enter a valid host': null,
                  onChanged: (val) {
                    setState(() => host = val);
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputTemplate.copyWith(hintText: 'Identifier'),
                  validator: (val) => val.length<6 && val.length>12 ? 'Enter a valid identifier': null,
                  onChanged: (val) {
                    setState(() => identifier = val);
                  },
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      dynamic result = await _manager.initialize(host: host, identifier: identifier);
                      if(result == MqttConnectionState.connected){
                        setState(() {
                          patata = result;
                        });
                      }else{
                        setState(() {
                          error = 'Could not connect with that host. Check syntaxis';
                        });
                      }
                    }
                  },
                  color: Colors.pink[900],
                  child: Text(
                    'Initialize Mqtt connection',
                    style: TextStyle(
                      color: Colors.pink[100],
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize:14.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
