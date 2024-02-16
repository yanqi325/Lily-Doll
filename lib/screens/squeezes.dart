import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/component/SqueezesCircularChart.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/screens/help_center.dart';
import '../component/AppBar.dart';
import '../component/SqueezeBarChart.dart';
import '../component/TouchesPart.dart';
import 'more_info.dart';

class Squeezes extends StatefulWidget {
  static const String id = 'squeezes';

  @override
  _SqueezesScreenState createState() => _SqueezesScreenState();
}

class _SqueezesScreenState extends State<Squeezes> {
  int? touchedBarIndex =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(
          title: 'Squeezes',
          icon: Icons.help,
          route: MoreInfo.id,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 15),
                        child: Text(
                          'Frequency of Squeeze',
                          style:
                              appLabelTextStyle.copyWith(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Average Squeeze Per Minute in a week',
                          style: appLabelTextStyle.copyWith(
                              color: purple4, fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 30,
                        color: purple4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              alignment: Alignment.topLeft,
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 16,
                              ),
                              onPressed: () {
                                //ADD ACTION HERE
                              },
                            ),
                            Text(
                              'This Week',
                              style: appLabelTextStyle.copyWith(
                                  color: Colors.white, fontSize: 13),
                            ),
                            Text(
                              'SPM XXX',
                              style: appLabelTextStyle.copyWith(
                                  color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SqueezesBarChartWidget(
                        onIndexChanged: (index) {
                          // Update the state with the new index
                          setState(() { //trigger the rebuild of Squeezes widget that contains the SqueezesBarChartWidget as its child.
                            touchedBarIndex = index;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 15),
                        child: Text('Time of day',
                            style: appLabelTextStyle.copyWith(color: Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Frequency of squeezes per day',
                          style: appLabelTextStyle.copyWith(
                              color: purple4, fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 12,),
                      SqueezesCircularChartWidget(
                        weekChoice: touchedBarIndex,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
