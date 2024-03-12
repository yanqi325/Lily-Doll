import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Data/SqueezesDataModel_PerDay.dart';
import '../constants.dart';

class SqueezesCircularChartWidget extends StatefulWidget {
  SqueezesCircularChartWidget({this.weekChoice, this.percentage});
  final int? weekChoice;
  final Map<String,double>? percentage;

  @override
  State<SqueezesCircularChartWidget> createState() => SqueezeCircularChart();
}

class SqueezeCircularChart extends State<SqueezesCircularChartWidget> {
  List _list = List.empty(growable: true);
  late int week;

  @override
  void initState() {
    super.initState();
    week = widget.weekChoice!;
    print('week in Circular: $week');
    _initializeList();
  }

  @override
  void didUpdateWidget(covariant SqueezesCircularChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.weekChoice != oldWidget.weekChoice) {
      setState(() {
        week = widget.weekChoice!;
      });
    }
  }

  void _initializeList() {
    _list.addAll([
      SqueezesDataModel(key: '1', value: '2', time1: '10', time2: '25', time3: '25', time4: '30'),
      SqueezesDataModel(key: '2', value: '5', time1: '20', time2: '25', time3: '25', time4: '30'),
      SqueezesDataModel(key: '3', value: '3', time1: '30', time2: '25', time3: '25', time4: '30'),
      SqueezesDataModel(key: '4', value: '7', time1: '40', time2: '25', time3: '25', time4: '30'),
      SqueezesDataModel(key: '5', value: '4', time1: '50', time2: '25', time3: '25', time4: '30'),
      SqueezesDataModel(key: '6', value: '8', time1: '60', time2: '25', time3: '25', time4: '30'),
      SqueezesDataModel(key: '7', value: '3', time1: '70', time2: '25', time3: '25', time4: '30'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    List<Color> chartColors = [
      Colors.blue,
      Colors.orangeAccent,
      purple6,
      purple4,
    ];

    List<String> label = [
      'Early Morning',
      'Morning',
      'Afternoon',
      'Night',
    ];

    List<String> timeLabel = [
      '00:01 - 06:00',
      '06:01 - 12:00',
      '12:01 - 18:00',
      '18:01 - 00:00',
    ];

    print(widget.percentage);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            for (int i = 0; i < 2; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int j = 0; j < 2; j++)
                    Column(
                      children: [
                        AnimatedCircularChart(
                          key: GlobalKey(), // Add a key
                          size: Size(120, 120),
                          initialChartData: <CircularStackEntry>[
                            CircularStackEntry(
                              <CircularSegmentEntry>[
                                CircularSegmentEntry(
                                  // double.parse(_list[week].getTimeProperty(i * 2 + j + 1)),
                                  (i == 0 && j==0) ? widget.percentage!['firstQuartile']!*100 : (i ==0 &&j==1) ? widget.percentage!['thirdQuartile']!*100 :(i == 1 && j==0) ? widget.percentage!['secondQuartile']!*100 : (i ==1 &&j==1) ? widget.percentage!['fourthQuartile']!*100 : 0 ,
                                  // widget.percentage!['firstQuartile']!*100,
                                  // 30,
                                  chartColors[i * 2 + j],
                                  rankKey: 'completed',
                                ),
                                CircularSegmentEntry(
                                  // 100 - double.parse(_list[week].getTimeProperty(i * 2 + j + 1)),
                                  100 -((i == 0 && j==0) ? widget.percentage!['firstQuartile']!*100 : (i ==0 &&j==1) ? widget.percentage!['thirdQuartile']!*100 :(i == 1 && j==0) ? widget.percentage!['secondQuartile']!*100 : (i ==1 &&j==1) ? widget.percentage!['fourthQuartile']!*100 : 0 ),
                                  // 100 - widget.percentage!['firstQuartile']!*100,
                                  // 70,
                                  chartColors[i * 2 + j].withOpacity(0.5),
                                  rankKey: 'remaining',
                                ),
                              ],
                              rankKey: 'progress',
                            ),
                          ],
                          chartType: CircularChartType.Radial,
                          percentageValues: true,
                          holeLabel:((i == 0 && j==0) ? (widget.percentage!['firstQuartile']!*100).toStringAsFixed(1) : (i ==0 &&j==1) ? (widget.percentage!['thirdQuartile']!*100).toStringAsFixed(1) :(i == 1 && j==0) ? (widget.percentage!['secondQuartile']!*100).toStringAsFixed(1) : (i ==1 &&j==1) ? (widget.percentage!['fourthQuartile']!*100).toStringAsFixed(1) : "0") + "%",
                          labelStyle: appLabelTextStyle.copyWith(color: Colors.black,),
                        ),
                        Text(
                          '${label[i * 2 + j]}',
                          style: appLabelTextStyle.copyWith(color: Colors.black, fontSize: 12),
                        ),
                        Text(
                          '${timeLabel[i * 2 + j]}',
                          style: appLabelTextStyle.copyWith(color: purple4, fontSize: 12),
                        ),
                        SizedBox(height: 18,),
                      ],
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
