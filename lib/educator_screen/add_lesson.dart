import 'package:flutter/material.dart';
import 'package:project_lily/component/CourseAvailable.dart';
import 'package:project_lily/component/EducatorNavigationBar.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/screens/course_description.dart';
import '../component/AddAttachment.dart';
import '../component/AppBar.dart';
import '../component/ContactCard.dart';
import '../component/EducatorTextField.dart';
import '../component/NavigationBar.dart';
import '../component/TextField.dart';
import '../component/UploadAddButton.dart';
import '../component/searchBar.dart';

class AddLesson extends StatefulWidget {
  static const String id = 'add_lesson';

  @override
  _AddLessonScreenState createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLesson> {
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  String? selectedValue; // Default selected value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(title: 'Sex Education'), //Courses.label
      ),
      body: Container(
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 455,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 19.0, right: 19, bottom: 12, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Add Lesson',
                                  style: appLabelTextStyle,
                                ),
                                IconButton(
                                    onPressed: (){Navigator.pop(context);},
                                    icon: Icon(Icons.cancel_outlined, color: purple4,))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            educator_textField(
                              title: 'Title',
                              hintText: 'Enter course title here',
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            educator_textField(
                              title: 'Description',
                              hintText: 'Enter course description here',
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Course Category',
                                    style: appLabelTextStyle.copyWith(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  SizedBox(height: 17,),
                                  DropdownMenu<String>(
                                    width: 300,
                                    menuHeight: 150,
                                    inputDecorationTheme: dropDownStyle,
                                    textStyle: appLabelTextStyle.copyWith(fontSize: 12, color: Colors.grey, fontFamily: fontFamily2,fontWeight: FontWeight.bold,),
                                    menuStyle: MenuStyle(maximumSize: MaterialStatePropertyAll(Size(300,100))),
                                    initialSelection: list.first,
                                    onSelected: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        selectedValue = value!;
                                      });
                                    },
                                    dropdownMenuEntries: list.map<DropdownMenuEntry<String>>(
                                            (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15,),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  educator_textField(
                                    title: 'Video Link',
                                    hintText: 'Enter course video link',
                                  ),
                                  SizedBox(height: 3,),
                                ],
                              ),
                            ),
                            UploadAddButton(title: 'Add',onPressed: (){},)


                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: EducatorNavigationBar(),
    );
  }
}


