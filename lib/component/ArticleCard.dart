import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/screens/web_view.dart';
import '../constants.dart';

class ArticleCard extends StatelessWidget {
  ArticleCard({this.articleTitle, this.appBarArticleTitle, this.image, this.url});

  String? articleTitle;
  String? appBarArticleTitle;
  String? image;
  String? url;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomWebView(
                articleTitle: appBarArticleTitle!,
                url: url,
              ), // Replace 'YOUR_URL_HERE' with the actual URL
            ),
          );
        },
        splashColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 140,
              height: 165,
              child: Image.asset(image!),
            ),
            SizedBox(height: 5,),
            Text(
              articleTitle!,
              style: appLabelTextStyle.copyWith(fontSize: 13, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
