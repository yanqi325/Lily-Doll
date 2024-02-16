import 'package:flutter/material.dart';
import 'package:project_lily/component/CourseAvailable.dart';
import 'package:project_lily/component/EducatorNavigationBar.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/screens/course_description.dart';
import '../component/AddAttachment.dart';
import '../component/ContactCard.dart';
import '../component/EducatorTextField.dart';
import '../component/NavigationBar.dart';
import '../component/TextField.dart';
import '../component/UploadAddButton.dart';
import '../component/searchBar.dart';

class UploadCourse extends StatefulWidget {
  static const String id = 'upload_course';

  @override
  _UploadCourseScreenState createState() => _UploadCourseScreenState();
}

class _UploadCourseScreenState extends State<UploadCourse> {
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  String? selectedValue; // Default selected value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Text(
                      'Manage Courses',
                      style: appLabelTextStyle.copyWith(fontSize: 30),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    searchBar(),
                    SizedBox(
                      height: 20,
                    ),
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
                                  'Upload Course',
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
                              title: 'Course Title',
                              hintText: 'Enter course title here',
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            educator_textField(
                              title: 'Course Description',
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
                                  Text(
                                    'Attachment',
                                    style: appLabelTextStyle.copyWith(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  SizedBox(height: 2,),
                                  AddAttachment(title: 'Add File', onPressed: (){},)
                                ],
                              ),
                            ),
                            UploadAddButton(title: 'Upload',onPressed: (){},)


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


