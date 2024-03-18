import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:project_lily/BluetoothService.dart';
import 'package:project_lily/constants.dart';

import '../Data/SqueezeTouchData.dart';
import '../component/AppBar.dart';
import '../helperMethods/DollDataAnalyzeHelper.dart';

class BluetoothPage extends StatefulWidget {
  static const String id = 'bluetooth_page';
  LocalBluetoothService? bleService;

  BluetoothPage({this.bleService});

  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> scanResults = [];
  bool isScanning = false;
  String unknown = 'Unknown';

  List<String> receivedData = [];
  List<String> touchDataString = [];

  // List<String> alreadyAddedData =[];
  List<SqueezeTouchData> touchData = [];
  DollDataAnalyzeHelper analyzeHelper = new DollDataAnalyzeHelper();
  bool _isDisposed = false;

  //dsfsdf

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: appBar(
          title: 'Bluetooth Scanner',
          fontSize: 25,
          icon: null,
        ), //Courses.label
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: isScanning ? null : _startScan,
            child: Text(
              'Start Scan',
              style: appBarLabel,
            ),
            style: ElevatedButton.styleFrom(
              primary: purple1, // Change this to your desired color
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  children: [
                    Text(
                      'Available Devices',
                      style: appBarLabel.copyWith(color: purple4, fontSize: 18),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     showDialog(
                    //         context: context,
                    //         builder: (BuildContext context) {
                    //           Timer(Duration(seconds: 10), () {
                    //             Navigator.of(context).pop();
                    //             //checkmark screen
                    //             showDialog(
                    //                 context: context,
                    //                 builder: (BuildContext context){
                    //                 Timer(Duration(seconds: 2), () {
                    //                   Navigator.of(context).pop();
                    //                 });
                    //                   return Dialog(
                    //                     backgroundColor: Colors.transparent,
                    //                     elevation: 0,
                    //                     child: Container(
                    //                       decoration: BoxDecoration(
                    //                         color: Colors.white,
                    //                         borderRadius: BorderRadius.circular(10),
                    //                       ),
                    //                       padding: EdgeInsets.all(20),
                    //                       child: Column(
                    //                         mainAxisSize: MainAxisSize.min,
                    //                         children: [
                    //                           Icon(Icons.done_outline_rounded,size: 80,),
                    //                           SizedBox(height: 20),
                    //                           Text('All data has been successfully fetched!',
                    //                             textAlign: TextAlign.center,
                    //                             style: TextStyle(fontSize: 16,),
                    //                             ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   );
                    //             });
                    //           });
                    //
                    //           return Dialog(
                    //             backgroundColor: Colors.transparent,
                    //             elevation: 0,
                    //             child: Container(
                    //               decoration: BoxDecoration(
                    //                 color: Colors.white,
                    //                 borderRadius: BorderRadius.circular(10),
                    //               ),
                    //               padding: EdgeInsets.all(20),
                    //               child: Column(
                    //                 mainAxisSize: MainAxisSize.min,
                    //                 children: [
                    //                   CircularProgressIndicator(),
                    //                   SizedBox(height: 20),
                    //                   Text('Fetching data ...',style: TextStyle(fontSize: 16),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           );
                    //         });
                    //   },
                    //   child: Text(
                    //     'Try',
                    //     style: appBarLabel,
                    //   ),
                    //   style: ElevatedButton.styleFrom(
                    //     primary: purple1, // Change this to your desired color
                    //   ),
                    // ),
                  ],
                ),
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: ListView.builder(
                itemCount: scanResults.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            scanResults[index].device.name.isNotEmpty
                                ? scanResults[index].device.name!
                                : unknown,
                          ),
                          subtitle:
                              Text(scanResults[index].device.id.toString()),
                          // onTap: () {
                          //   _connectToDevice(scanResults[index].device);
                          //   // Add your dialog code here
                          // },
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: PopupMenuButton(
                          icon: Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Icon(Icons.more_vert_rounded),
                          ),
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              child: Text('Connect'),
                              value: 'connect',
                            ),
                            PopupMenuItem(
                              child: Text('Disconnect'),
                              value: 'disconnect',
                            ),
                          ],
                          onSelected: (value) async {
                            if (value == 'connect') {
                              // _connectToDevice(scanResults[index].device);
                              widget.bleService!
                                  .connectToDevice(scanResults[index].device);
                              //establishing connection
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    Timer(Duration(seconds: 5), () {
                                      Navigator.of(context).pop();

                                      //downloading data
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            Timer(Duration(seconds: 5), () {
                                              Navigator.of(context).pop();

                                              //done screen
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    Timer(Duration(seconds: 2),
                                                        () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                    return Dialog(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        padding:
                                                            EdgeInsets.all(20),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .done_outline_rounded,
                                                              size: 60,
                                                              color: Colors
                                                                  .deepPurple,
                                                            ).animate().fade(
                                                                delay: 400.ms),
                                                            SizedBox(height: 8),
                                                            Text(
                                                              'All data has been successfully fetched!',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            });
                                            return Dialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                padding: EdgeInsets.all(20),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.download,
                                                      size: 60,
                                                      color: Colors.deepPurple,
                                                    )
                                                        .animate(
                                                          onPlay: (controller) =>
                                                              controller
                                                                  .repeat(), // loop
                                                        )
                                                        .fade(delay: 650.ms),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      'Downloading data...',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    });

                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircularProgressIndicator(),
                                            SizedBox(height: 20),
                                            Text(
                                              'Establishing connection...',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });

                              // Navigator.pushNamed(context, LoadingAnimation.id);
                            } else if (value == 'disconnect') {
                              Object? result =
                                  await scanResults[index].device.disconnect();
                              print(result);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    Timer(Duration(seconds: 1), () {
                                      Navigator.of(context).pop();
                                    });
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Disconnected',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isProcessingData = false;
  List<String> _dataBuffer = [];

  // void _startListening(BluetoothDevice device) async {
  //   List<BluetoothService> services = await device.discoverServices();
  //   services.forEach((service) {
  //     service.characteristics.forEach((characteristic) {
  //       if (characteristic.properties.notify) {
  //         characteristic.setNotifyValue(true).then((value) {
  //           if (!_isDisposed) {
  //             // Check if widget is disposed
  //             characteristic.value.listen((data) {
  //               setState(() {
  //                 if (!_isDisposed) {
  //                   // Check if widget is disposed
  //                   String dataString = String.fromCharCodes(data);
  //                   if (dataString.toLowerCase() != "connecting" &&
  //                       dataString != "0") {
  //                     _dataBuffer.add(dataString);
  //                     print(dataString);
  //                   }// Add received data to buffer
  //                   receivedData.add(String.fromCharCodes(data));
  //                   _processData(); // Process the data
  //                 }
  //               });
  //             });
  //           }
  //         });
  //       }
  //     });
  //   });
  // }

  // void _startListening(BluetoothDevice device) async {
  //   List<BluetoothService> services = await device.discoverServices();
  //   services.forEach((service) {
  //     service.characteristics.forEach((characteristic) {
  //       if (characteristic.properties.notify) {
  //         characteristic.setNotifyValue(true).then((value) {
  //           if (!mounted) {
  //             // Check if the widget is disposed
  //             return;
  //           }
  //           if (!_isDisposed) {
  //             // Check if widget is disposed
  //             characteristic.value.listen((data) {
  //               setState(() {
  //                 if (!_isDisposed) {
  //                   // Check if widget is disposed
  //                   String dataString = String.fromCharCodes(data);
  //                   // String dataString = String.fromCharCodes(data);
  //                   print(dataString);
  //                   if (dataString.toLowerCase() != "connecting" &&
  //                       dataString != "0") {
  //                     _dataBuffer.add(dataString);
  //                     print(dataString);
  //                   }
  //                   receivedData.add(String.fromCharCodes(data));
  //                   _processData(); // Process the data
  //                 }
  //               });
  //             });
  //           }
  //         });
  //       }
  //     });
  //   });
  // }

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

  void _startScan() {
    setState(() {
      scanResults.clear();
      isScanning = true;
    });

    flutterBlue.startScan(timeout: Duration(seconds: 5));

    flutterBlue.scanResults.listen((results) {
      setState(() {
        scanResults = results;
      });
    });

    flutterBlue.isScanning.listen((isScanning) {
      print('Scanning: $isScanning');
      if (!isScanning) {
        setState(() {
          this.isScanning = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect(autoConnect: false);
      //go to page
      print('Connected to device: ${device.name}');
      // Navigate to a new page or perform other actions
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => BluetoothDataListener(device: device)),
      // );
      widget.bleService!.startListening(device);
      // _startListening(device);
    } catch (e) {
      print('Failed to connect to device: $e');
    }
  }
}
