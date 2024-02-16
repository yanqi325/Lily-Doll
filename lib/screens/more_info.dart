import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/component/SqueezesCircularChart.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/screens/help_center.dart';
import 'package:project_lily/screens/web_view.dart';
import '../component/ArticleCard.dart';
import '../component/AppBar.dart';
import '../component/SqueezeBarChart.dart';
import '../component/TouchesPart.dart';

class MoreInfo extends StatefulWidget {
  static const String id = 'more_info';

  @override
  _MoreInfoScreenState createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(
          title: 'More Information',
        ),
      ),
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ArticleCard(articleTitle: 'XXXX',image: 'images/article1.png', url: 'https://www.medicalnewstoday.com/articles/319496'),
                    ArticleCard(articleTitle: 'XXXX',image: 'images/article2.png', url: 'https://www.medicalnewstoday.com/articles/319496'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ArticleCard(articleTitle: 'XXXX',image: 'images/article3.png', url: 'https://www.medicalnewstoday.com/articles/319496'),
                  ArticleCard(articleTitle: 'XXXX',image: 'images/article4.png', url: 'https://www.medicalnewstoday.com/articles/319496'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

