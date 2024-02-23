import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:project_lily/component/Avatar.dart';
import 'package:project_lily/component/ElevatedButton.dart';
import 'package:project_lily/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../Data/Users.dart';
import '../component/AppBar.dart';
import '../component/Cardboard.dart';
import '../component/NavigationBar.dart';
import '../component/ToggleButton.dart';
import '../component/ToggleButtonCard.dart';

class BluetoothPage extends StatefulWidget {
  static const String id = 'bluetooth_page';
  @override
  _BluetoothPageScreenState createState() => _BluetoothPageScreenState();
}

class _BluetoothPageScreenState extends State<BluetoothPage> {
  bool isPressed = false;
  bool isConnect = false;
  String isConnectLabel = '';

  List<BluetoothDevice> devices = [];
  final FlutterBlue flutterBlue = FlutterBlue.instance;


  @override
  void initState() {
    super.initState();
    _startScan();
  }

  void _startScan() {
    flutterBlue.scanResults.listen((List<ScanResult> scanResults) {
      for (ScanResult scanResult in scanResults) {
        if (!devices.contains(scanResult.device)) {
          setState(() {
            devices.add(scanResult.device);
          });
        }
      }
    });
    flutterBlue.startScan();
  }

  void _connectToDevice(BluetoothDevice device) async {
    device.connect().then((value) => print("Connected"));
    // Connection established, now you can exchange data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(title: 'Bluetooth'),
      ),
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ToggleButtonCard(label: 'Bluetooth',),
              SizedBox(height: 20,),
              Text('Devices',
                style: appBarLabel.copyWith(color: purple4, fontSize: 18),),
              SizedBox(height: 12,),
              ElevatedButton(
                onPressed: () {
                 if (isConnect == false){
                   showDialog(
                     context: context,
                     builder: (BuildContext context) {
                       return AlertDialog(
                         title: Text('Connect Device', style: appLabelTextStyle),
                         content: Text('Do you wish to connect this device?'),
                         actions: [
                           ElevatedButton(
                             onPressed: () {
                               Navigator.pop(context);
                             },
                             child: Text('CANCEL'),
                           ),
                           ElevatedButton(
                             onPressed: () {
                               setState(() {
                                 isConnect = true;
                                 isConnectLabel = 'Connected';
                               });
                               Navigator.pop(context);
                             },
                             child: Text('Connect'),
                           ),
                         ],
                       );
                     },
                   );
                 }
                 else{
                   showDialog(
                     context: context,
                     builder: (BuildContext context) {
                       return AlertDialog(
                         title: Text('Disconnect Device', style: appLabelTextStyle),
                         content: Text('Do you wish to disconnect this device?'),
                         actions: [
                           ElevatedButton(
                             onPressed: () {
                               Navigator.pop(context);
                             },
                             child: Text('CANCEL'),
                           ),
                           ElevatedButton(
                             onPressed: () {
                               setState(() {
                                 isConnect = false;
                                 isConnectLabel = '';
                               });
                               Navigator.pop(context);
                             },
                             child: Text('Disconnect'),
                           ),
                         ],
                       );
                     },
                   );
                 }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xDDE6D3F6),
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                child:
    ListView.builder(
    itemCount: devices.length,
    shrinkWrap: true,
    itemBuilder: (BuildContext context, int index) {
      BluetoothDevice device = devices[index];
      return ListTile(
        title: Text(device.name),
        onTap: () {
          _connectToDevice(device);
        },
      );
    }
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // children: [
                  //   Text(
                  //     'LilyDoll',
                  //     style: appBarLabel.copyWith(color: Colors.black, fontSize: 16),
                  //   ),
                  //   SizedBox(width: 50),
                  //   Text(
                  //     '$isConnectLabel',style: appLabelTextStyle.copyWith(color: Colors.lightGreen),
                  //   ),
                  // ],
                ),
              ),

            ],
          ),
        ),
      ),


    );
  }

}

