import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:project_lily/Data/Users.dart';
import 'package:project_lily/component/AppBar.dart';
import 'package:project_lily/component/ElevatedButton.dart';
import 'package:project_lily/constants.dart';
import 'package:project_lily/screens/course_description.dart';
import 'package:project_lily/screens/profile_page.dart';
import '../Data/Courses.dart';
import '../component/CoursesCard.dart';
import '../component/IconButton.dart';
import '../component/LessonCard.dart';
import '../component/NavigationBar.dart';

class CourseVideo extends StatefulWidget {
  static const String id = 'course_video';

  @override
  _CourseVideoScreenState createState() => _CourseVideoScreenState();
}

class _CourseVideoScreenState extends State<CourseVideo> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  void initState() {
    super.initState();

    try {
      setAudio();

      //listen to state change from time to time
      audioPlayer.onPlayerStateChanged.listen((state) {
        setState(() {
          isPlaying = state == PlayerState.playing;
        });
      });

      //listen to duration change from time to time
      audioPlayer.onDurationChanged.listen((newDuration) {
        setState(() {
          duration = newDuration;
        });
      });

      //listen to position change from time to time
      audioPlayer.onPositionChanged.listen((newPosition) {
        setState(() {
          position = newPosition;
        });
      });
    } catch (e) {
      print('Error in initState: $e');
    }
  }

  void dispose(){
    audioPlayer.dispose();
    super.dispose();
  }

  Future setAudio() async{
    //repeat when completed
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    String url = 'https://cdn.pixabay.com/audio/2024/01/04/audio_896a3bc8f7.mp3';
    //https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3
    audioPlayer.setSourceUrl(url);
    //  audioPlayer.setUrl('assets/music.mp3', isLocal: true);
  }


  String formatTime(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2,'0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return[
      if (duration.inHours>0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(initialIndex: 0,),
      body: Container(
        color: backgroundColor2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 105,),
                  Column(
                    children: [
                      Text('Lesson 1', style: appLabelTextStyle.copyWith(color: Colors.black, fontSize: 20),),
                      Text('Title', style: appLabelTextStyle.copyWith(color: Colors.black, fontFamily: fontFamily2, fontWeight: FontWeight.bold, fontSize: 18),)
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 100,),
            Container(
              width: 600,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/course_material.png'), // Replace with your image path
                  fit: BoxFit.cover, // Adjust the BoxFit as needed
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (double value) async{
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
                await audioPlayer.resume();

              },
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position)),
                  Text(formatTime(duration-position)),
                ],
              ),
            ),
            
            CircleAvatar(
                radius:35,
                child: IconButton(
                  color: Color(0xFF572675),
                  icon: Icon(
                    isPlaying ? Icons.pause: Icons.play_arrow,
                  ),
                  iconSize: 50,
                  onPressed: () async{
                    if(isPlaying) {
                      await audioPlayer.pause();
                    }else{
                      await audioPlayer.resume();
                    }
                  },
                )
            )


          ],
        ),

      ),
    );
  }
}

