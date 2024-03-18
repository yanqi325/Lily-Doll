import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';

import 'Data/SqueezeTouchData.dart';
import 'helperMethods/DollDataAnalyzeHelper.dart';

class LocalBluetoothService {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  StreamController<String> _dataStreamController = StreamController<String>();

  Stream<String> get dataStream => _dataStreamController.stream;

  List<String> receivedData = [];
  List<String> touchDataString = [];
  // List<String> alreadyAddedData =[];
  List<SqueezeTouchData> touchData = [];
  DollDataAnalyzeHelper analyzeHelper = new DollDataAnalyzeHelper();
  bool _isDisposed = false;
  bool _isProcessingData = false;
  List<String> _dataBuffer = [];

  void startListening(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      service.characteristics.forEach((characteristic) {
        if (characteristic.properties.notify) {
          characteristic.setNotifyValue(true).then((value) {
            characteristic.value.listen((data) {
              String dataString = String.fromCharCodes(data);
              _dataStreamController.add(dataString); // Send data to stream
            });
          });
        }
      });
    });
  }

  void dispose() {
    _dataStreamController.close();
  }

  void _processData() {
    if (!_isProcessingData) {
      _isProcessingData = true; // Set flag to indicate processing
      Timer(Duration(seconds: 10), () {
        // Schedule function call after 10 seconds

          // Call the processing function with the buffered data
          analyzeHelper.decodeDollDataBLE(_dataBuffer);
          _dataBuffer.clear(); // Clear the data buffer
          _isProcessingData = false; // Reset flag after processing
      });
    }
  }
}
