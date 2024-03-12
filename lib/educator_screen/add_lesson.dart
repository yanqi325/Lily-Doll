import 'package:flutter/material.dart';
import 'package:project_lily/Data/Lessons.dart';
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
import '../helperMethods/DbHelper.dart';

class AddLesson extends StatefulWidget {
  static const String id = 'add_lesson';
  String? lessonTitleS='';

  AddLesson({
    this.lessonTitleS
});

  @override
  _AddLessonScreenState createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLesson> {
  List<String> lessonsCategory = ["DailyHabits","Science","Maths"];
  String lessonTitle='';
  String lessonDesc='';
  String lessonCategory='';
  String thumbnailUrl='';

  String? selectedValue; // Default selected value

  void onChangedCallbackTitle(String value) {
    lessonTitle = value;
    // print(enteredValue); // Print the entered value
  }

  void onChangedCallbackDesc(String value){
    lessonDesc = value;
  }

  @override
  Widget build(BuildContext context) {

    // final Map<String, dynamic> args =
    // ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: appBar(title: widget.lessonTitleS), //Courses.label
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
                              onChanged: onChangedCallbackTitle, isSelection: false
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            educator_textField(
                              title: 'Description',
                              hintText: 'Enter course description here',
                              onChanged: onChangedCallbackDesc,
                              isSelection: false
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
                                    initialSelection: lessonsCategory.first,
                                    onSelected: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        lessonCategory = value!;
                                      });
                                    },
                                    dropdownMenuEntries: lessonsCategory.map<DropdownMenuEntry<String>>(
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
                                      isSelection: false
                                  ),
                                  SizedBox(height: 3,),
                                ],
                              ),
                            ),
                            UploadAddButton(title: 'Add',onPressed: (){

                              //find enum value based on string
                              lessonCategory = lessonCategory.toLowerCase();
                              LessonCategory? selectedCategory;
                              for (var category in LessonCategory.values) {
                                if (category.toString().toLowerCase() == 'lessoncategory.$lessonCategory') {
                                  selectedCategory = category;
                                  break;
                                }

                              }
                              //try adding courses to firebase
                              if(selectedCategory != null){
                                // print("course ttitle here is: " + args["courseTitle"].toString());
                                Lessons lessonEnteredByUser= new Lessons(lessonTitle, lessonDesc, selectedCategory!, thumbnailUrl,true);
                                DbHelper dbHelper = new DbHelper();
                                dbHelper.addLessonToFirestore(lessonEnteredByUser,widget.lessonTitleS!);
                                print("Tried to upload lesson");
                                Navigator.pop(context);
                                print("Popped add lesson page");
                              }else{

                              }
                              print("pressedUploadLesson");
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


