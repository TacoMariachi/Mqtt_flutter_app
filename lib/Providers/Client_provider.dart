import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';

class MQTTClientProvider with ChangeNotifier {
  MqttServerClient _client;

  MqttServerClient get client => _client;

  void setClient(MqttServerClient client){
    this._client = client;
    //print(_client.connectionStatus);
    //print(_client.clientIdentifier);
    hasListeners ? print('Si hay alguien suscrito') : print('NO HAY NADIEN PUTAM MADRE ');
    notifyListeners();
  }
}