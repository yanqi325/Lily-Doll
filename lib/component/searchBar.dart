import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/constants.dart';

class searchBar extends StatelessWidget {
  searchBar({ this.width=500, this.height=40});
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textEditingController = TextEditingController();

    return SearchBar(
      leading: Icon(Icons.search, color: Colors.grey,),
      backgroundColor: MaterialStatePropertyAll(Color(0xFFE0D0F8)),
      overlayColor: MaterialStateProperty.all(Colors.white),
      elevation: MaterialStateProperty.all(2.0),
      constraints: BoxConstraints(
        maxWidth: width!,
        minHeight: height!,
      ),
      textStyle: MaterialStateProperty.all(
          const TextStyle(color: Colors.black, fontFamily: fontFamily)
      ),
      hintText: 'Search',
      hintStyle: MaterialStateProperty.all(const TextStyle(color: Colors.grey)),
      controller: _textEditingController,
      onChanged: (String value) {
        print('value: $value');
      },
        //https://www.woolha.com/tutorials/flutter-using-searchbar-widget-examples


    );
  }
}
