import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/screens/chatroom.dart';

import '../Data/Users.dart';
import '../constants.dart';
import '../helperMethods/DbHelper.dart';
import '../screens/lessonVideoYT.dart';

class ManageLessonCard extends StatefulWidget {
  final String? coursePath;
  final String? imagePath;
  final String? courseNameFull;
  final String? courseTitle;
  final String? lessonTitle;
  final String? status;
  final VoidCallback? moreOption;
  final void Function(String?)? onValueChanged;
  LessonVideoYT videoPage;

  ManageLessonCard({
    this.coursePath,
    this.imagePath,
    this.courseNameFull,
    this.courseTitle,
    this.status,
    this.moreOption,
    this.onValueChanged,
    this.lessonTitle,
    required this.videoPage
  });

  @override
  ManageLessonCardClass createState() =>
      ManageLessonCardClass(onValueChanged: onValueChanged!);
}

class ManageLessonCardClass extends State<ManageLessonCard> {
  TextEditingController searchController = TextEditingController();

  final void Function(String?) onValueChanged;

  ManageLessonCardClass({required this.onValueChanged});

  static String? touched = 'manage';

  DbHelper dbHelper = new DbHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              //navigate to lesson video page
              //DEFAULT
              // Navigator.pushNamed(context, widget.coursePath!);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => widget.videoPage),
              );
            },
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    width: 56,
                    height: 56,
                    image: AssetImage(widget.imagePath!),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:210,
                        child: Text(
                          widget.courseNameFull!,
                          style: appLabelTextStyle,
                          softWrap: true,
                        ),
                      ),
                      if (widget.status != null) ...[
                        Text(
                          widget.status!,
                          style: appLabelTextStyle.copyWith(
                            fontSize: 10,
                            fontFamily: fontFamily,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 25,
            child: IconButton(
              icon: const Icon(Icons.more_vert_rounded),
              color: purple4,
              onPressed: () {
                print('more option tapped');
                showPopupMenu(context);
              },
            ),
          )
        ],
      ),
    );
  }

  void showPopupMenu(BuildContext context) {

    String? studentName;
    GlobalKey _popupKey = GlobalKey();

    // Find the RenderBox of the IconButton
    RenderBox button = context.findRenderObject() as RenderBox;

    // Get the global position of the button
    var position = button.localToGlobal(Offset.zero);

    // Calculate the offset for the PopupMenu
    double topOffset = position.dy + button.size.height;
    double leftOffset = position.dx;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(leftOffset, topOffset, 20, 0),
      items: [
        const PopupMenuItem(
          value: 'everyone',
          child: ListTile(
            title: Text('Unlock for everyone'),
          ),
        ),
        PopupMenuItem(
          key: _popupKey,
          value: 'student',
          child: ListTile(
            title: Row(
              children: [
                const Text('Unlock for '),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 100,
                  height: 30,
                  child: Center(
                    child: SearchBar(
                      elevation: MaterialStateProperty.all(0.0),
                      textStyle: MaterialStateProperty.all( const TextStyle(
                        color: Colors.black,
                        fontFamily: fontFamily2,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                      hintText: 'Student',
                      hintStyle: MaterialStateProperty.all(const TextStyle(
                        color: Colors.grey,
                        fontFamily: fontFamily2,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                      controller: searchController,
                      onSubmitted: (String value) {
                        print('value: $value');
                        studentName = value;
                        searchController.clear();
                        onValueChanged!('Unlocked for $studentName');
                        Navigator.of(context).pop();
                      },

                    ),
                  ),

                ),
              ],
            ),
          ),
        ),
        const PopupMenuItem(
          value: 'lock',
          child: ListTile(
            title: Text('Lock this course'),
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      // Handle the selected option here
      if (value == 'everyone') {
        onValueChanged!('Unlocked');
        dbHelper.updateLessonLockStatus(widget.courseTitle!,widget.lessonTitle!, false);

        //unlock lesson in backend here
      } else if (value == 'student' && studentName==null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Text('Please provide the name of the student you want to grant access to the cours\.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (value == 'lock') {
        onValueChanged!('Locked');
        //lock lesson in backend here
        onValueChanged!('Unlocked');
        dbHelper.updateLessonLockStatus(widget.courseTitle!,widget.lessonTitle!, true);
      }
    });
  }
}
