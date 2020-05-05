import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MQTTMessageProvider with ChangeNotifier {
  String _message;

  String get message => _message;

  void setMessage(String message){
    this._message = message;
    notifyListeners();
  }
}