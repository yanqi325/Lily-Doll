import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:project_lily/helperMethods/DbHelper.dart'; // Import your DbHelper class here

class LessonVideoYT extends StatefulWidget {
  static const String id = 'lesson_video_yt';

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
    String videoId = await dbHelper.getVideoIdFromLesson(); // Replace with your method to get the video ID
    return videoId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson Video'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _videoIdFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Display loading indicator while fetching the video ID
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Initialize the YoutubePlayerController with the fetched video ID
              _controller = YoutubePlayerController(
                initialVideoId: snapshot.data!,
                flags: YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              );
              return YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }
}
