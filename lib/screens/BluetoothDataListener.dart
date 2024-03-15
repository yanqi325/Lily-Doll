import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:project_lily/Data/SqueezeTouchData.dart';
import 'package:project_lily/helperMethods/DbHelper.dart';
import 'package:project_lily/helperMethods/DollDataAnalyzeHelper.dart';

class BluetoothDataListener extends StatefulWidget {
  final BluetoothDevice device;

  const BluetoothDataListener({Key? key, required this.device})
      : super(key: key);

  @override
  _BluetoothDataListenerState createState() => _BluetoothDataListenerState();
}

class _BluetoothDataListenerState extends State<BluetoothDataListener> {
  List<String> receivedData = [];
  List<String> touchDataString = [];
  // List<String> alreadyAddedData =[];
  List<SqueezeTouchData> touchData = [];
  DollDataAnalyzeHelper analyzeHelper = new DollDataAnalyzeHelper();
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

  bool _isProcessingData = false;
  List<String> _dataBuffer = [];

  void _startListening() async {
    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service) {
      service.characteristics.forEach((characteristic) {
        if (characteristic.properties.notify) {
          characteristic.setNotifyValue(true).then((value) {
            if (!_isDisposed) {
              // Check if widget is disposed
              characteristic.value.listen((data) {
                setState(() {
                  if (!_isDisposed) {
                    // Check if widget is disposed
                    String dataString = String.fromCharCodes(data);
                    if (dataString.toLowerCase() != "connecting" &&
                        dataString != "0") {
                      _dataBuffer.add(dataString);
                    }// Add received data to buffer
                    receivedData.add(String.fromCharCodes(data));
                    _processData(); // Process the data
                  }
                });
              });
            }
          });
        }
      });
    });
  }

  void _processData() {
    if (!_isProcessingData) {
      _isProcessingData = true; // Set flag to indicate processing
      Timer(Duration(seconds: 10), () {
        // Schedule function call after 10 seconds
        setState(() {
          // Call the processing function with the buffered data
          analyzeHelper.decodeDollDataBLE(_dataBuffer);
          _dataBuffer.clear(); // Clear the data buffer
          _isProcessingData = false; // Reset flag after processing
        });
      });
    }
  }

//   void _startListening() async {
//     List<BluetoothService> services = await widget.device.discoverServices();
//     services.forEach((service) {
//       service.characteristics.forEach((characteristic) {
//         if (characteristic.properties.notify) {
//           characteristic.setNotifyValue(true).then((value) {
//             if (!_isDisposed) {
//               // Check if widget is disposed
//               characteristic.value.listen((data) {
//                 if (!_isDisposed) {
//                   // Check if widget is disposed
//                   // Future.delayed(Duration(seconds: 10));
//                   print("Received Data");
//                   setState(() {
//                     //wait 10 seconds -> put loading screen
//                     receivedData.add(String.fromCharCodes(data));
//                     //filter data and add correct data to touchData
//                     String dataString = String.fromCharCodes(data);
//                     if (dataString.toLowerCase() != "connecting" &&
//                         dataString != "0") {
//                       touchDataString.add(dataString);
//
// //dsd
//                     }
//                     Future.delayed(Duration(seconds: 10));
//                     analyzeHelper.decodeDollDataBLE(touchDataString);
//                     touchDataString = [];
//                     //sadasdas
//                   }
//
//                 );
//                 }
//               });
//             }
//           });
//         }
//       });
//     });
//   }
}
