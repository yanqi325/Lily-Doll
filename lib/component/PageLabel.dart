import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class PageLabel extends StatelessWidget {
  const PageLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: purple4,
            ),
          ),
          Expanded(
            child: Center(
              child: Text('Description',
                style: appBarLabel.copyWith(fontSize: 30, color: purple4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

