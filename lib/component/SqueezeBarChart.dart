import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/Data/SqueezesDataModel_PerDay.dart';

//https://youtu.be/TPd49hhnfXI?si=NW99wOVsf-0lihbz

class SqueezesBarChartWidget extends StatefulWidget {
  final void Function(int?) onIndexChanged;
  final Map<int,int>? dailySqueeze;

  SqueezesBarChartWidget({required this.onIndexChanged,this.dailySqueeze});

  @override
  State<SqueezesBarChartWidget> createState() => SqueezeBarChart(onIndexChanged: onIndexChanged);
}

class SqueezeBarChart extends State<SqueezesBarChartWidget> {
  final void Function(int?) onIndexChanged;

  SqueezeBarChart({required this.onIndexChanged});
  static int? touchedBarIndex=0; // Class-level variable to store the touchedBarIndex
  List _list = List.empty(growable: true);

  void initState() {
    super.initState();
    _list.add(SqueezesDataModel(key: '1', value: '2', time1: '20', time2: '25', time3: '25', time4: '30'));
    _list.add(SqueezesDataModel(key: '2', value: '5', time1: '20', time2: '25', time3: '25', time4: '30'));
    _list.add(SqueezesDataModel(key: '3', value: '3', time1: '20', time2: '25', time3: '25', time4: '30'));
    _list.add(SqueezesDataModel(key: '4', value: '7', time1: '20', time2: '25', time3: '25', time4: '30'));
    _list.add(SqueezesDataModel(key: '5', value: '4', time1: '20', time2: '25', time3: '25', time4: '30'));
    _list.add(SqueezesDataModel(key: '6', value: '8', time1: '20', time2: '25', time3: '25', time4: '30'));
    _list.add(SqueezesDataModel(key: '7', value: '3', time1: '20', time2: '25', time3: '25', time4: '30'));
  }

  @override
  Widget build(BuildContext context) {
    widget.dailySqueeze!.forEach((key, value) {
      print(widget.dailySqueeze![key]);
    });
    return Container(
      child: AspectRatio(
        aspectRatio: 2,
        child: BarChart(
          BarChartData(
            borderData: FlBorderData(
              show: false,
            ),
            gridData: FlGridData(
              show: false,
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                // Customize the x-axis labels here
                  sideTitles: _bottomTiles
              ),
            ),
            groupsSpace: 10,
            barGroups: _chartGroups(),
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.blueAccent,
              ),
              touchCallback: (event, touchResponse) {
                // Handle touch interaction here
                if (touchResponse?.spot != null) {
                  // A bar was touched
                  SqueezeBarChart.touchedBarIndex = touchResponse?.spot!.touchedBarGroupIndex!;
                  print('Touched bar at index: $touchedBarIndex');
                  onIndexChanged(touchedBarIndex);

                }
              },
            ),

          ),
        ),
      ),
    );
  }
  int? get getTouchedBarIndex => touchedBarIndex;


  SideTitles get _bottomTiles =>
      SideTitles(
        showTitles: true,
        getTitlesWidget: (double value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 0:
              text = "Sun";
              break;
            case 1:
              text = 'Mon';
              break;
            case 2:
              text = 'Tue';
              break;
            case 3:
              text = 'Wed';
              break;
            case 4:
              text = 'Thu';
              break;
            case 5:
              text = 'Fri';
              break;
            case 6:
              text = 'Sat';
              break;
            case 7:
              text = 'Sun';
              break;
          }
          return Text(
            text,
            style: TextStyle(fontSize: 10),
          );
        },
      );

  List<BarChartGroupData> _chartGroups() {
    List<BarChartGroupData> list = List<BarChartGroupData>.empty(
        growable: true);
    for (int i = 1; i <= 7; i++) {
      list.add(BarChartGroupData(x: i, barRods: [
        BarChartRodData(
            toY: widget.dailySqueeze![i]!.toDouble(), color: Color(0xFFDA7BFC), width: 15)
      ]));
    }
    return list;
  }
}

//Need to have one method to extract all the Week 1 data, week2  etc