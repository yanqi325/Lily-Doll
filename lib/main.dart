import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_lily/educator_screen/add_lesson.dart';
import 'package:project_lily/educator_screen/dashboard.dart';
import 'package:project_lily/educator_screen/enrolled_studentlist.dart';
import 'package:project_lily/educator_screen/enrollment.dart';
import 'package:project_lily/educator_screen/manage_courses_detail.dart';
import 'package:project_lily/educator_screen/student_details.dart';
import 'package:project_lily/educator_screen/upload_course.dart';
import 'package:project_lily/screens/SignUp_user_page.dart';
import 'package:project_lily/screens/bluetooth.dart';
import 'package:project_lily/helperMethods/DollDataAnalyzeHelper.dart';
import 'package:project_lily/screens/chat.dart';
import 'package:project_lily/screens/chatroom.dart';
import 'package:project_lily/screens/course_video.dart';
import 'package:project_lily/screens/about_us.dart';
import 'package:project_lily/screens/course_description.dart';
import 'package:project_lily/screens/courses_chapter.dart';
import 'package:project_lily/screens/courses_page.dart';
import 'package:project_lily/screens/data_report.dart';
import 'package:project_lily/screens/forgot_password.dart';
import 'package:project_lily/screens/help_center.dart';
import 'package:project_lily/screens/home_page.dart';
import 'package:project_lily/screens/language.dart';
import 'package:project_lily/screens/loadingPage.dart';
import 'package:project_lily/screens/login_page.dart';
import 'package:project_lily/screens/more_info.dart';
import 'package:project_lily/screens/notification.dart';
import 'package:project_lily/screens/profile_page.dart';
import 'package:project_lily/screens/setting_page.dart';
import 'package:project_lily/screens/signup_page.dart';
import 'package:project_lily/screens/squeezes.dart';
import 'package:project_lily/screens/touches.dart';
import 'package:project_lily/screens/user_page.dart';
import 'package:project_lily/screens/verification.dart';
import 'package:project_lily/screens/web_view.dart';
import 'package:project_lily/screens/welcome_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'BluetoothService.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });

  // testing
  // DbHelper dbHelper = new DbHelper();
  // List<SqueezeTouchData>? dataList =
  //     await dbHelper.getDataFromAllDateSubcollections("1-1-2024");
  // dataList!.forEach((element) {
  //   print(element.pressure);
  // });

  // DollDataAnalyzeHelper dollDataAnalyzeHelper = new DollDataAnalyzeHelper();
  // Map<int,int> data = await dollDataAnalyzeHelper.getDataProcessedForThisWeek("01-01-2024");
  // print("THISISSPARTAAAA");
  // data.forEach((key, value) {
  //   // print("wEEDKLY DATA" + data[key].toString());
  // });
}

class MyApp extends StatelessWidget {
  //pass this to bluetooth connection page, and to the squeeze data page
  LocalBluetoothService bleService = LocalBluetoothService();



  @override
  Widget build(BuildContext context) {
    bleService.initServices();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          UserPage.id: (context) => UserPage(),
          LoginPage.id: (context) => LoginPage(),
          SignUpPage.id: (context) => SignUpPage(),
          ForgotPassword.id: (context) => ForgotPassword(),
          Verification.id: (context) => Verification(),
          HomePage.id: (context) => HomePage(),
          ProfilePage.id: (context) => ProfilePage(),
          SettingPage.id: (context) => SettingPage(),
          NotificationPage.id: (context) => NotificationPage(),
          LanguagePage.id: (context) => LanguagePage(),
          HelpCenter.id: (context) => HelpCenter(),
          AboutUs.id: (context) => AboutUs(),
          CoursesPage.id: (context) => CoursesPage(),
          CourseDescription.id: (context) => CourseDescription(
                courseTitle: '',
                numOfStudents: 0,
                descText: '',
                imagePath: '',
                altText: '',
                isEnrolled: false,
                isEducatorMode: false,
              isOnlineAsset: false
              ),
          CoursesChapter.id: (context) => CoursesChapter(),
          CourseVideo.id: (context) => CourseVideo(),
          DataReport.id: (context) => DataReport(),
          Touches.id: (context) => Touches(),
          Squeezes.id: (context) => Squeezes(),
          MoreInfo.id: (context) => MoreInfo(),
          CustomWebView.id: (context) => CustomWebView(),
          Chat.id: (context) => Chat(),
          Chatroom.id: (context) => Chatroom(),
          Dashboard.id: (context) => Dashboard(),
          UploadCourse.id: (context) => UploadCourse(),
          ManageCoursesDetail.id: (context) => ManageCoursesDetail(),
          AddLesson.id: (context) => AddLesson(),
          EnrolledStudentList.id: (context) => EnrolledStudentList(),
          Enrollment.id: (context) => Enrollment(),
          StudentDetails.id: (context) => StudentDetails(courseTitle: "",userName: ""),
          SignUpUserPage.id: (context) => SignUpUserPage(),
          BluetoothPage.id: (context) => BluetoothPage(bleService: bleService,),
          LoadingAnimation.id: (context) => LoadingAnimation(),
        });
  }
}
