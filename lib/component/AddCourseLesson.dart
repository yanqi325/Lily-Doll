import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../educator_screen/upload_course.dart';

class AddButton extends StatelessWidget {
  AddButton({
    this.title,
    this.path
  });
  final String? title;
  final String? path;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(title!);
        Navigator.pushNamed(context, path!);
      },
      child: Container(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.add,
                  size: 19,
                  color: Colors.black,
                ),
                Text(
                  title!,
                  style: appLabelTextStyle.copyWith(
                      color: Colors.black, fontSize: 14),
                )
              ],
            ),
          )),
    );
  }
}
