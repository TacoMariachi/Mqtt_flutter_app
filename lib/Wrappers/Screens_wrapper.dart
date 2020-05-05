import 'package:finalprojectapp/Providers/Client_provider.dart';
import 'package:finalprojectapp/Providers/Message_provider.dart';
import 'package:finalprojectapp/Services/Mqtt_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finalprojectapp/Screens/Mqtt_publish.dart';
import 'package:finalprojectapp/Screens/Mqtt_subscribe.dart';

class ScreensWrapper extends StatefulWidget {
  @override
  _ScreensWrapperState createState() => _ScreensWrapperState();
}

class _ScreensWrapperState extends State<ScreensWrapper> {
  String selectedButton;
  //MQTTManager _manager = MQTTManager();
  int _selectedPage = 0;
  MQTTClientProvider clientProvider;

  final _pageOptions = [
    MQTTSubscribe(),
    MQTTPublish(),
  ];

  @override
  Widget build(BuildContext context) {
    //final manager = Provider.of<MQTTManager>(context);
    final MQTTManager managerProvider = Provider.of<MQTTManager>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Subscribe'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
              managerProvider.disconnect();
            },
            icon: Icon(Icons.arrow_back),
            label: Text('return'),
          ),
        ],
      ),
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey[200],
        fixedColor: Colors.blueGrey[900],
        currentIndex: _selectedPage,
        type: BottomNavigationBarType.fixed,
        onTap: (int index){
          setState((){
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            title: Text('Subscribe'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.publish),
            title: Text('Publish'),
          ),
        ],
      ),
    );
  }
}
