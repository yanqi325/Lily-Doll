// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue/flutter_blue.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:project_lily/component/Avatar.dart';
// import 'package:project_lily/component/ElevatedButton.dart';
// import 'package:project_lily/constants.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import '../Data/Users.dart';
// import '../component/AppBar.dart';
// import '../component/Cardboard.dart';
// import '../component/NavigationBar.dart';
// import '../component/ToggleButton.dart';
// import '../component/ToggleButtonCard.dart';
//
// class BluetoothPage extends StatefulWidget {
//   static const String id = 'bluetooth_page';
//
//   @override
//   _BluetoothPageScreenState createState() => _BluetoothPageScreenState();
// }
//
// class _BluetoothPageScreenState extends State<BluetoothPage> {
//   bool isPressed = false;
//   bool isConnect = false;
//   String isConnectLabel = '';
//
//   List<BluetoothDevice> devices = [];
//   final FlutterBlue flutterBlue = FlutterBlue.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     _startScan();
//     // startScanCustom();
//   }
//
//   Future<void> _startScan() async {
//     // Request permission
//     PermissionStatus status = await Permission.bluetoothScan.request();
//     PermissionStatus connectStatus = await Permission.bluetoothConnect.request();
//
//     flutterBlue.startScan();
//
//     if(status.isGranted && connectStatus.isGranted){
//       flutterBlue.scanResults.listen((List<ScanResult> scanResults) {
//         for (ScanResult scanResult in scanResults) {
//           if (!devices.contains(scanResult.device) && scanResult.device.name.toLowerCase() =="DHT22") {
//             setState(() {
//               devices.add(scanResult.device);
//               print("added devices");
//             });
//             // print("Added device based on bluetooth:" + scanResult.device.name);
//           }
//         }
//       });
//
//     }
//
//
//
//   }
//
//   void _connectToDevice(BluetoothDevice device) async {
//     try{
//       device.connect().then((value) => print("Connected"));
//     }catch (e){
//       print("Error is" +  e.toString());
//     }
//
//     // Connection established, now you can exchange data
//   }
//
//   Future<void> checkServices(BluetoothDevice device) async {
//     List<BluetoothService> services = await device.discoverServices();
//     services.forEach((service) {
//       // do something with service
//       print("Service name: " + service.uuid.toString());
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(85),
//         child: appBar(title: 'Bluetooth'),
//       ),
//       body: Container(
//         color: backgroundColor,
//         child: Padding(
//           padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
//           child: ListView(
//             // crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ToggleButtonCard(
//                 label: 'Bluetooth',
//                 onChange: () =>{
//                   // startScanCustom()
//                   _startScan()
//                 },
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 'Devices',
//                 style: appBarLabel.copyWith(color: purple4, fontSize: 18),
//               ),
//               SizedBox(
//                 height: 12,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   if (isConnect == false) {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title:
//                               Text('Connect Device', style: appLabelTextStyle),
//                           content: Text('Do you wish to connect this device?'),
//                           actions: [
//                             ElevatedButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Text('CANCEL'),
//                             ),
//                             ElevatedButton(
//                               onPressed: () {
//                                 setState(() {
//                                   isConnect = true;
//                                   isConnectLabel = 'Connected';
//                                 });
//                                 Navigator.pop(context);
//                               },
//                               child: Text('Connect'),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   } else {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Text('Disconnect Device',
//                               style: appLabelTextStyle),
//                           content:
//                               Text('Do you wish to disconnect this device?'),
//                           actions: [
//                             ElevatedButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Text('CANCEL'),
//                             ),
//                             ElevatedButton(
//                               onPressed: () {
//                                 setState(() {
//                                   isConnect = false;
//                                   isConnectLabel = '';
//                                 });
//                                 Navigator.pop(context);
//                               },
//                               child: Text('Disconnect'),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Color(0xDDE6D3F6),
//                   onPrimary: Colors.black,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(13),
//                   ),
//                 ),
//                 child: ListView.builder(
//                     itemCount: devices.length,
//                     shrinkWrap: true,
//                     itemBuilder: (BuildContext context, int index) {
//                       BluetoothDevice device = devices[index];
//                       return ListTile(
//                         title: Text(device.name),
//                         onTap: () {
//                           _connectToDevice(device);
//                           checkServices(device);
//                         },
//                       );
//                     }
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     // children: [
//                     //   Text(
//                     //     'LilyDoll',
//                     //     style: appBarLabel.copyWith(color: Colors.black, fontSize: 16),
//                     //   ),
//                     //   SizedBox(width: 50),
//                     //   Text(
//                     //     '$isConnectLabel',style: appLabelTextStyle.copyWith(color: Colors.lightGreen),
//                     //   ),
//                     // ],
//                     ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/screens/BluetoothDataListener.dart';
import 'package:project_lily/screens/loadingPage.dart';

import '../component/AppBar.dart';

class BluetoothPage extends StatefulWidget {
  static const String id = 'bluetooth_page';
  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> scanResults = [];
  bool isScanning = false;
  String unknown = 'Unknown';

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
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // Timer(Duration(seconds: 10), () {
                              //   Navigator.of(context).pop(); // Close the dialog
                              // });

                              return Dialog(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircularProgressIndicator(),
                                      SizedBox(height: 20),
                                      Text('Loading',style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text(
                        'Try',
                        style: appBarLabel,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: purple1, // Change this to your desired color
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: ListView.builder(
                itemCount: scanResults.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.withOpacity(0.3))),
                        ),
                        child: ListTile(
                          title: Text(scanResults[index].device.name.isNotEmpty
                              ? scanResults[index].device.name!
                              : unknown),
                          subtitle:
                              Text(scanResults[index].device.id.toString()),
                          onTap: () {
                            print(scanResults[index].device);
                            //connect
                            //direct ti page

                            _connectToDevice(scanResults[index].device);

                            // Navigator.pushNamed(context, LoadingAnimation.id);
                          },
                        ),
                      ),
                      // ElevatedButton(onPressed: ()=>{}, child: Text("Connect"))
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

  void _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect(autoConnect: false);
      //go to page
      print('Connected to device: ${device.name}');
      // Navigate to a new page or perform other actions
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BluetoothDataListener(device: device)),
      );
    } catch (e) {
      print('Failed to connect to device: $e');
    }
  }
}
