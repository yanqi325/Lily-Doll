import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/Data/Courses.dart';
import 'package:project_lily/component/CourseAvailable.dart';
import 'package:project_lily/component/EducatorNavigationBar.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/helperMethods/DbHelper.dart';
import 'package:project_lily/screens/course_description.dart';
import '../Data/Lessons.dart';
import '../component/AddAttachment.dart';
import '../component/ContactCard.dart';
import '../component/EducatorTextField.dart';
import '../component/NavigationBar.dart';
import '../component/TextField.dart';
import '../component/UploadAddButton.dart';
import '../component/searchBar.dart';

class ModifyCourse extends StatefulWidget {
  static const String id = 'upload_course';
  String? courseName;
  String? lessonTitle;
  bool isLesson;
  bool isCourse;

  ModifyCourse(
      {this.courseName,
      this.lessonTitle,
      required this.isLesson,
      required this.isCourse});

  @override
  _ModifyCourseScreenState createState() => _ModifyCourseScreenState();
}

class _ModifyCourseScreenState extends State<ModifyCourse> {
  List<String> coursesCategory = ["DailyHabits", "Science", "Maths"];
  String courseTitle = '';
  String courseDesc = '';
  String courseCategory = '';
  String thumbnailUrl = '';

  DbHelper dbHelper = new DbHelper();

  String? selectedValue; // Default selected value

  void onChangedCallbackTitle(String value) {
    courseTitle = value;
    // print(enteredValue); // Print the entered value
  }

  void onChangedCallbackDesc(String value) {
    courseDesc = value;
  }



  @override
  Widget build(BuildContext context) {

courseCategory = coursesCategory.first;
    String educatorId = (FirebaseAuth.instance.currentUser)!.uid;
    // _futureCourse = dbHelper.getCourseDocument(educatorId, widget.courseName!);
    // print(educatorId);
    // print(course)
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
          height: 650,
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
                          padding: EdgeInsets.only(
                              left: 19.0, right: 19, bottom: 12, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Modify Course',
                                    style: appLabelTextStyle,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.cancel_outlined,
                                        color: purple4,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              widget.isLesson
                                  ? FutureBuilder<Lessons?>(
                                      future: dbHelper.getLessonFromFirestore(
                                          widget.lessonTitle ?? '',
                                          widget.courseName ?? ''),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          // While waiting for the future to resolve, return a loading indicator or placeholder.
                                          return CircularProgressIndicator(); // Or any loading indicator widget
                                        } else if (snapshot.hasError) {
                                          // If an error occurs while fetching data, return an error message or handle the error gracefully.
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          // If the future completes successfully, extract the lesson data from the snapshot and populate the educator_textField widget with it.
                                          Lessons? lesson = snapshot.data;

                                          if (lesson != null) {
                                            return Column(
                                              children: [
                                                educator_textField(
                                                  title: 'Lesson Title',
                                                  hintText:
                                                      'Enter lesson title here',
                                                  initialValue:
                                                      lesson.lessonTitle,
                                                  // Populate with course title
                                                  isSelection: false,
                                                  onChanged:
                                                      onChangedCallbackTitle,
                                                ),
                                                SizedBox(height: 15),
                                                educator_textField(
                                                  title: 'Lesson Description',
                                                  hintText:
                                                      'Enter lesson description here',
                                                  initialValue:
                                                      lesson.lessonDesc,
                                                  // Populate with course description
                                                  isSelection: false,
                                                  onChanged:
                                                      onChangedCallbackDesc,
                                                ),
                                                // Add more educator_textField widgets for other fields if needed
                                              ],
                                            );
                                          } else {
                                            // Handle the case where the lesson data is null.
                                            return Text('Lesson data is null.');
                                          }
                                        }
                                      },
                                    )
                                  : FutureBuilder<Courses?>(
                                      future: dbHelper.getCourseDocument(
                                          educatorId, widget.courseName!),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          // While waiting for the future to resolve, return a loading indicator or placeholder.
                                          return CircularProgressIndicator(); // Or any loading indicator widget
                                        } else if (snapshot.hasError) {
                                          // If an error occurs while fetching data, return an error message or handle the error gracefully.
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          // If the future completes successfully, extract the lesson data from the snapshot and populate the educator_textField widget with it.
                                          Courses? course = snapshot.data;
                                          print(course!.courseTitle);
                                          print(course!.courseDesc);
                                          if (course != null) {
                                            return Column(
                                              children: [
                                                educator_textField(
                                                  title: 'Course Title',
                                                  hintText:
                                                      'Enter course title here',
                                                  initialValue:
                                                      course.courseTitle,
                                                  // Populate with course title
                                                  isSelection: false,
                                                  onChanged:
                                                      onChangedCallbackTitle,
                                                ),
                                                SizedBox(height: 15),
                                                educator_textField(
                                                  title: 'Course Description',
                                                  hintText:
                                                      'Enter course description here',
                                                  initialValue:
                                                      course.courseDesc,
                                                  // Populate with course description
                                                  isSelection: false,
                                                  onChanged:
                                                      onChangedCallbackDesc,
                                                ),
                                                // Add more educator_textField widgets for other fields if needed
                                              ],
                                            );
                                          } else {
                                            // Handle the case where the lesson data is null.
                                            return Text('Course data is null.');
                                          }
                                        }
                                      },
                                    ),
                              // educator_textField(
                              //     title: 'Course Title',
                              //     hintText: 'Enter course title here',
                              //     onChanged: onChangedCallbackTitle,
                              //     isSelection: false),
                              // SizedBox(
                              //   height: 15,
                              // ),
                              // educator_textField(
                              //     title: 'Course Description',
                              //     hintText: 'Enter course description here',
                              //     onChanged: onChangedCallbackDesc,
                              //     isSelection: false),
                              // SizedBox(
                              //   height: 15,
                              // ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Course Category',
                                      style: appLabelTextStyle.copyWith(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 17,
                                    ),
                                    DropdownMenu<String>(
                                      width: 260,
                                      menuHeight: 150,
                                      inputDecorationTheme: dropDownStyle,
                                      textStyle: appLabelTextStyle.copyWith(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontFamily: fontFamily2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      menuStyle: MenuStyle(
                                          maximumSize: MaterialStatePropertyAll(
                                              Size(300, 100))),
                                      initialSelection: "DailyHabits",
                                      onSelected: (String? value) {
                                        // This is called when the user selects an item.
                                        setState(() {
                                          courseCategory = value!;
                                        });
                                      },
                                      dropdownMenuEntries: coursesCategory
                                          .map<DropdownMenuEntry<String>>(
                                              (String value) {
                                        return DropdownMenuEntry<String>(
                                            value: value, label: value);
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Thumbnail',
                                      style: appLabelTextStyle.copyWith(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    AddAttachment(
                                      title: 'Add File',
                                      onPressed: () async {
                                        //show file picker to upload files
                                        DbHelper dbHelper = new DbHelper();
                                        thumbnailUrl =
                                            await dbHelper.uploadImage();
                                      },
                                    )
                                  ],
                                ),
                              ),
                              UploadAddButton(
                                title: 'Modify',
                                onPressed: () {
                                  //find enum value based on string
                                  courseCategory = courseCategory.toLowerCase();
                                  CourseCategory? selectedCategory;
                                  LessonCategory? selectedCategoryLesson;
                                  for (var category in CourseCategory.values) {
                                    if (category.toString().toLowerCase() ==
                                        'coursecategory.$courseCategory') {
                                      selectedCategory = category;

                                      break;
                                    }
                                  }
                                  for (var category in LessonCategory.values) {
                                    if (category.toString().toLowerCase() ==
                                        'coursecategory.$courseCategory') {
                                      selectedCategoryLesson = category;

                                      break;
                                    }
                                  }
                                  //try adding courses to firebase
                                  //modify course func

                                  DbHelper dbHelper = new DbHelper();
                                  if (widget.isCourse) {
                                    Courses courseEnteredByUser = new Courses(
                                        widget.courseName!,
                                        courseDesc,
                                        selectedCategory!,
                                        thumbnailUrl,
                                        0);
                                    print(courseEnteredByUser.courseTitle);
                                    dbHelper.updateCourseInFirestore(
                                        courseEnteredByUser);
                                    // dbHelper.addCourseToFirestore(courseEnteredByUser);
                                    print("sdf");

                                    // dbHelper.addCourseToFirestore(
                                    //     courseEnteredByUser);
                                    Navigator.pop(context);
                                  } else {
                                    Lessons lessonEnteredByUser = new Lessons(
                                      widget.courseName!,
                                      courseDesc,
                                      selectedCategoryLesson!,
                                      thumbnailUrl,
                                    );
                                    dbHelper.updateLessonInFirestore(
                                        lessonEnteredByUser, courseTitle);
                                    print("sdf2");
                                  }
                                },
                              )
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
      ),
      bottomNavigationBar: EducatorNavigationBar(),
    );
  }
}
