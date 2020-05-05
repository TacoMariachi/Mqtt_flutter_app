import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:finalprojectapp/Providers/Message_provider.dart';
import 'package:finalprojectapp/Providers/Client_provider.dart';


class MQTTManager with ChangeNotifier{
  //Properties
  MqttServerClient client;
  MQTTMessageProvider messageProvider = MQTTMessageProvider();
  String _identifier;
  String _topic;
  String _host;

  //Getters

  //Setters

  Future initialize({String host, String identifier}) async {
    MqttServerClient _client = MqttServerClient(host, identifier);
    this._identifier = _client.clientIdentifier;
    this._host = host;
    _client.port = 1883;
    _client.keepAlivePeriod = 20;
    _client.onDisconnected = onDisconnected;
    _client.onConnected = onConnected;
    _client.onSubscribed = onSubscribed;
    _client.logging(on: false);

    final conMess = MqttConnectMessage()
        .withClientIdentifier(identifier)
        .keepAliveFor(20)
        .withWillTopic('willtopic')
        .withWillMessage('willmessage')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    _client.connectionMessage = conMess;

    try {
      MqttClientConnectionStatus result = await _client.connect('BBFF-qkHkFkvJ6oFUw9m6Pa9bzQTCbVCddH','');
      this.client = _client;
      notifyListeners();
      return result.state;
    } on Exception catch (e) {
      print('Something went wrong $e');
      disconnect();
      return null;
    }
  }

  void subscription({String topic}) {
    this._topic = topic;
    print('EXAMPLE::Subscribing to the $_topic topic');
    this.client.subscribe(this._topic, MqttQos.atMostOnce);
  }

  void unsubscribe({String topic}) {
    print('unsubscribing from $topic');
    this.client.unsubscribe(topic);
    print('Unsubscribbed!');
  }

  void publish({String topic, String message}) async {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    this.client.publishMessage(topic, MqttQos.atMostOnce, builder.payload);
  }

  void disconnect() async {
    await MqttUtilities.asyncSleep(2);
    print('EXAMPLE::Disconnecting');
    this.client.disconnect();
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    this._topic = topic;
    print('EXAMPLE::Subscription confirmed for topic $this._topic');
    this.client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage _recMess = c[0].payload;
      final String _message =
      MqttPublishPayload.bytesToStringAsString(_recMess.payload.message);
      messageProvider.setMessage(_message);
    });
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (this.client.connectionStatus.returnCode == MqttConnectReturnCode.solicited) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
  }

  /// The successful connect callback
  void onConnected() {
    print(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');
  }

  /// Pong callback
  void pong() {
    print('EXAMPLE::Ping response client callback invoked');
  }
}





