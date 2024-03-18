import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/helperMethods/DbHelper.dart';
import 'package:project_lily/helperMethods/DollDataAnalyzeHelper.dart';
import '../component/AppBar.dart';
import '../component/TouchesPart.dart';

class Touches extends StatefulWidget {
  static const String id = 'touches';

  @override
  _TouchesScreenState createState() => _TouchesScreenState();
}

class _TouchesScreenState extends State<Touches> {

  String getFormattedDate(DateTime date) {
    // Define the date format
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    // Format the date using the formatter
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    DollDataAnalyzeHelper dollDataAnalyzeHelper = new DollDataAnalyzeHelper();
    // Get today's date
    DateTime now = DateTime.now();
    // Format the date
    String formattedDate = getFormattedDate(now);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(85),
          child: appBar(title: 'Touches',
          icon: null,),
        ),
        body:
        FutureBuilder<Map<String, double>>(
            future: dollDataAnalyzeHelper.calculateTouchPercentages(formattedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                Map<String, double> touchData = snapshot.data ?? {};
                print(touchData);
                return SingleChildScrollView(
                  child: Container(
                    color: backgroundColor,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Center(
                            child: Container(
                              child: Image.asset(
                                'images/bunny.png',
                                scale: 2.2,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20.0, left: 20.0, top: 3.0, bottom: 30),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(children: [
                                    Row(
                                      mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Location',
                                                style: appLabelTextStyle.copyWith(
                                                    color: Colors.black, fontSize: 25),
                                              ),
                                              Text(
                                                'Most touched areas',
                                                style: appLabelTextStyle.copyWith(
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.refresh),
                                          onPressed: () {
                                            setState(() {}); // This will trigger a rebuild of the FutureBuilder
                                          },
                                        ),
                                      ],
                                    ),
                                  ],),


                                  SizedBox(
                                    height: 20,
                                  ),
                                  TouchesPart(
                                    label: 'Head',
                                    color: Colors.blue,
                                    percentage: touchData["sensor1"] != null? touchData["sensor1"]: 0,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TouchesPart(
                                    label: 'Body',
                                    color: Colors.orangeAccent,
                                    percentage: touchData["sensor2"] != null? touchData["sensor2"]: 0,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TouchesPart(
                                    label: 'Leg',
                                    color: purple5,
                                    percentage: 0,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TouchesPart(
                                    label: 'Hand',
                                    color: purple4,
                                    percentage: 0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}
