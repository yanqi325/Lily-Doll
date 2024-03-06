import 'package:flutter/material.dart';
import 'package:project_lily/component/EducatorNavigationBar.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/helperMethods/DbHelper.dart';
import '../component/AddAttachment.dart';
import '../component/EducatorTextField.dart';
import '../component/UploadAddButton.dart';
import '../helperMethods/AuthHelper.dart';

class Enrollment extends StatefulWidget {
  static const String id = 'enrollment';

  @override
  _EnrollmentScreenState createState() => _EnrollmentScreenState();
}

class _EnrollmentScreenState extends State<Enrollment> {
  String userName='';
  String userId = '';

  void onChangedCallbackName(String value) {
    userName = value;
    // print(enteredValue); // Print the entered value
  }
  void onChangedCallbackId(String value) {
    userId = value;
    // print(enteredValue); // Print the entered value
  }

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      body: Container(
        color: backgroundColor2,
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
                      'Enroll Student',
                      style: appLabelTextStyle.copyWith(fontSize: 30),
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
                        padding: EdgeInsets.only(left: 19.0, right: 19, bottom: 12, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Add Student',
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
                              title: 'Username',
                              hintText: 'Enter username here',
                              onChanged: onChangedCallbackName,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            educator_textField(
                              title: 'User ID',
                              hintText: 'Enter user id here',
                              onChanged: onChangedCallbackId,
                            ),
                            SizedBox(
                              height: 170,
                            ),

                            UploadAddButton(title: 'Add',onPressed: () async {
                                DbHelper dbHelper = new DbHelper();
                                AuthHelper authHelper = new AuthHelper();
                                String? educatorId = await authHelper.getCurrentUserId();
                                //get user id
                                String userId = await dbHelper.getUsernamesFromUsersExtended(userName);
                                // add user id to 'enrolledUsers'
                                dbHelper.addUserToEnrolledUsers(educatorId!, args["courseTitle"], userId);
                                dbHelper.addUserToEnrolledCourses(userId, args["courseTitle"],educatorId);
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
    );
  }
}


