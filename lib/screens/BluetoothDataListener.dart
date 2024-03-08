import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothDataListener extends StatefulWidget {
  final BluetoothDevice device;

  const BluetoothDataListener({Key? key, required this.device}) : super(key: key);

  @override
  _BluetoothDataListenerState createState() => _BluetoothDataListenerState();
}

class _BluetoothDataListenerState extends State<BluetoothDataListener> {
  List<String> receivedData = [];
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Data Listener'),
      ),
      body: ListView.builder(
        itemCount: receivedData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(receivedData[index]),
          );
        },
      ),
    );
  }

  void _startListening() async {
    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service) {
      service.characteristics.forEach((characteristic) {
        if (characteristic.properties.notify) {
          characteristic.setNotifyValue(true).then((value) {
            if (!_isDisposed) { // Check if widget is disposed
              characteristic.value.listen((data) {
                if (!_isDisposed) { // Check if widget is disposed
                  setState(() {
                    print("Received Data");
                    receivedData.add(String.fromCharCodes(data));
                  });
                }
              });
            }
          });
        }
      });
    });
  }
}
