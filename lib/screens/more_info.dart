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
                    ArticleCard(
                        articleTitle: 'Anxiety Reasons',
                        appBarArticleTitle: 'Anxiety Reasons',
                        image: 'images/article1.png',
                        url:
                            'https://www.iidc.indiana.edu/irca/articles/what-triggers-anxiety-for-an-individual-with-asd.html'),
                    ArticleCard(
                        articleTitle: 'About Autism',
                        appBarArticleTitle: 'About Autism',
                        image: 'images/article2.png',
                        url:
                            'https://www.icdl.com/parents/about-autism?gad_source=1&gclid=Cj0KCQjwncWvBhD_ARIsAEb2HW-lNUKqPWD7PNhY3QboWkglOVYaFkYJj-gSBjYGCU7KvkC0xmClRnMaAqzYEALw_wcB'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ArticleCard(
                      articleTitle: 'Deep Pressure Therapy',
                      appBarArticleTitle: 'Therapy',
                      image: 'images/article3.png',
                      url: 'https://otsimo.com/en/deep-pressure-therapy-autism/'),
                  ArticleCard(
                      articleTitle: 'Autism and Anger',
                      image: 'images/article4.png',
                      appBarArticleTitle: 'Autism and Anger',
                      url: 'https://hiddentalentsaba.com/autism-and-anger/#:~:text=Autistic%20Children%20and%20Their%20Struggle,can%20turn%20into%20anger%20ruminations.'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
