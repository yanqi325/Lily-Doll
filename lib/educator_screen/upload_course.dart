import 'package:flutter/material.dart';
import 'package:project_lily/Data/Courses.dart';
import 'package:project_lily/component/CourseAvailable.dart';
import 'package:project_lily/component/EducatorNavigationBar.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/helperMethods/DbHelper.dart';
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
  List<String> coursesCategory = ["DailyHabits","Science","Maths"];
  String courseTitle='';
  String courseDesc='';
  String courseCategory='';
  String thumbnailUrl='';

  String? selectedValue; // Default selected value

  void onChangedCallbackTitle(String value) {
    courseTitle = value;
    // print(enteredValue); // Print the entered value
  }

  void onChangedCallbackDesc(String value){
    courseDesc = value;
  }

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
                              onChanged: onChangedCallbackTitle,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            educator_textField(
                              title: 'Course Description',
                              hintText: 'Enter course description here',
                              onChanged: onChangedCallbackDesc,
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
                                    initialSelection: "DailyHabits",
                                    onSelected: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        courseCategory = value!;
                                      });
                                    },
                                    dropdownMenuEntries: coursesCategory.map<DropdownMenuEntry<String>>(
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
                                    'Thumbnail',
                                    style: appLabelTextStyle.copyWith(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  SizedBox(height: 2,),
                                  AddAttachment(title: 'Add File', onPressed: () async {
                                    //show file picker to upload files
                                    DbHelper dbHelper = new DbHelper();
                                    thumbnailUrl= await dbHelper.uploadImage();
                                  },)
                                ],
                              ),
                            ),
                            UploadAddButton(title: 'Upload',onPressed: (){

                              //find enum value based on string
                              courseCategory = courseCategory.toLowerCase();
                              CourseCategory? selectedCategory;
                              for (var category in CourseCategory.values) {
                                if (category.toString().toLowerCase() == 'coursecategory.$courseCategory') {
                                  selectedCategory = category;
                                  break;
                                }
                              }
                              //try adding courses to firebase
                              if(selectedCategory != null){
                                Courses courseEnteredByUser= new Courses(courseTitle, courseDesc, selectedCategory!, thumbnailUrl,0);
                                DbHelper dbHelper = new DbHelper();
                                dbHelper.addCourseToFirestore(courseEnteredByUser);
                                Navigator.pop(context);
                              }else{

                              }
                            },)


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


