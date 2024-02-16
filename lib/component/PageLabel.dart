import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class PageLabel extends StatelessWidget {
  const PageLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 40.0),
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
            child: Padding(
              padding: const EdgeInsets.only(left: 80.0),
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

