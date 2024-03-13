import 'package:flutter/material.dart';
import 'package:project_lily/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:project_lily/helperMethods/DbHelper.dart';

import '../component/NavigationBar.dart'; // Import your DbHelper class here

class LessonVideoYT extends StatefulWidget {
  static const String id = 'lesson_video_yt';
  bool isUser;
  String lessonTitle;
  String lessonNo;
  String courseTitle;

  LessonVideoYT({
    required this.isUser,
    required this.lessonTitle,
    required this.lessonNo,
    required this.courseTitle
  });

  @override
  _LessonVideoYTState createState() => _LessonVideoYTState();
}

class _LessonVideoYTState extends State<LessonVideoYT> {
  late Future<String> _videoIdFuture;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _videoIdFuture = _fetchVideoId(); // Fetch the YouTube video ID
  }

  Future<String> _fetchVideoId() async {
    // Fetch the YouTube video ID asynchronously from your DbHelper class
    DbHelper dbHelper = DbHelper(); // Initialize your DbHelper
    String videoId="";
    //depending on if it is user/educator, use different methods
    if(widget.isUser){
      videoId = await dbHelper.getVideoIdFromLessonUser(widget.lessonTitle,widget.courseTitle);
    }else{
      videoId = await dbHelper.getVideoIdFromLessonEducator(widget.lessonTitle,widget.courseTitle);
    }
   // Replace with your method to get the video ID
    return videoId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: _videoIdFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(), // Display loading indicator while fetching the video ID
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Initialize the YoutubePlayerController with the fetched video ID
            _controller = YoutubePlayerController(
              initialVideoId: snapshot.data!,
              flags: YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
              ),
            );
            return _buildVideoPlayer();
          }
        },
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Lesson "+ widget.lessonNo, style: appLabelTextStyle.copyWith(color: Colors.black, fontSize: 20),),
                  Text(widget.lessonTitle, style: appLabelTextStyle.copyWith(color: Colors.black, fontFamily: fontFamily2, fontWeight: FontWeight.bold, fontSize: 18),)
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 100,),
        YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }
}
