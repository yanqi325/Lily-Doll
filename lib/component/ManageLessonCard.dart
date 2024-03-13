import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/screens/chatroom.dart';

import '../Data/Users.dart';
import '../constants.dart';
import '../helperMethods/AuthHelper.dart';
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
  List<String>? popupItems;

  ManageLessonCard({
    this.coursePath,
    this.imagePath,
    this.courseNameFull,
    this.courseTitle,
    this.status,
    this.moreOption,
    this.onValueChanged,
    this.lessonTitle,
    required this.videoPage,
    this.popupItems
  });

  @override
  ManageLessonCardClass createState() =>
      ManageLessonCardClass(onValueChanged: onValueChanged!);
}

class ManageLessonCardClass extends State<ManageLessonCard> {

  String userEnteredValue = "";
  String studentName = "";
  TextEditingController _controller = TextEditingController();

  void showPopup(BuildContext context) async {
    if (widget.popupItems != null) {
      final String? selectedItem = await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(0, 0, 0, 0),
        items: widget.popupItems!.map((item) {
          return PopupMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      );
      if (selectedItem != null) {
        // Handle the selected item
        setState(() {
          userEnteredValue = selectedItem;
          changeTextFieldText(selectedItem);
          print("changed text to " + selectedItem);
        });
        if (widget.onValueChanged != null) {
          widget.onValueChanged!(selectedItem);
        }
      }
    }
  }
  void changeTextFieldText(String newText) {
    _controller.text = newText;
    studentName = newText;// Set the text using the controller
  }

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
                      Text(
                        widget.courseNameFull!,
                        style: appLabelTextStyle,
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
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            color: purple4,
            onPressed: () {
              print('more option tapped');
              showPopupMenu(context);
            },
          )
        ],
      ),
    );
  }

  void showPopupMenu(BuildContext context) {

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
                      controller: _controller,
                      onTap: (){
                        showPopup(context);
                        print("show pop up");
                      },
                      onSubmitted: (String value) async {
                        print('value15332: $value');
                        studentName = value;
                        // searchController.clear();
                        onValueChanged!('Unlocked for $studentName');
                        //unlock for user -> lesson (set)
                        //serach by user

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
    ).then((value) async {
      // Handle the selected option here
      if (value == 'everyone') {
        onValueChanged!('Unlocked');
        dbHelper.updateLessonLockStatus(widget.courseTitle!,widget.lessonTitle!, false);

        //unlock lesson in backend here
      } else if (value == 'student' && studentName=="") {
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
      }else if (value =='student' && !(studentName=="")){
        print("SDFSDFS00");
        AuthHelper authHelper =
        new AuthHelper();
        String userId = await dbHelper
            .getUsernamesFromUsersExtended(
            studentName!);
        String? educatorId = await authHelper
            .getCurrentUserId();
        dbHelper.addFieldsToLessonDocumentUserSingle(userId, widget.courseTitle!,widget.lessonTitle!,educatorId!, true);
        print("changed isUnlocked status");
      }
      else if (value == 'lock') {
        onValueChanged!('Locked');
        //lock lesson in backend here
        onValueChanged!('Unlocked');
        dbHelper.updateLessonLockStatus(widget.courseTitle!,widget.lessonTitle!, true);
      }
    });
  }
}
