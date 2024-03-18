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

  LocalBluetoothService(){

  }

  void initServices()async{
    DollDataAnalyzeHelper dollDataAnalyzeHelper = new DollDataAnalyzeHelper();
    await dollDataAnalyzeHelper.initializeTotalAdditions();
  }

  void startListening(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      service.characteristics.forEach((characteristic) {
        if (characteristic.properties.notify) {
          characteristic.setNotifyValue(true).then((value) {
            characteristic.value.listen((data) {
              String dataString = String.fromCharCodes(data);
              _dataStreamController.add(dataString);

              if (dataString.toLowerCase() != "connecting" &&
                  dataString != "0") {
                _dataBuffer.add(dataString);
                print(dataString);
              } // Add received data to buffer
              receivedData.add(String.fromCharCodes(data));
              _processData(); // Send data to stream
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
      Timer(Duration(seconds: 5), () {
        // Schedule function call after 10 seconds

        // Call the processing function with the buffered data
        analyzeHelper.decodeDollDataBLE(_dataBuffer);
        _dataBuffer.clear(); // Clear the data buffer
        _isProcessingData = false; // Reset flag after processing
      });
    }
  }



  void connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect(autoConnect: false);
      //go to page
      print('Connected to device: ${device.name}');
      // Navigate to a new page or perform other actions
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => BluetoothDataListener(device: device)),
      // );
      startListening(device);
      // _startListening(device);

    } catch (e) {
      print('Failed to connect to device: $e');
    }
  }
}
