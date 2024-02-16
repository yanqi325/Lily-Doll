import 'package:flutter/material.dart';
import 'package:project_lily/constants.dart';

class Chatroom extends StatefulWidget {
  static const String id = 'chatroom';

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<Chatroom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: EdgeInsets.all(35.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView(
                  //padding: EdgeInsets.only(top:90,),
                  reverse: true, //make the view of message always stick to the bottom
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 65,),
                        Container(
                          height: MediaQuery.of(context).size.height - 260, // Adjusted height
                          color: Colors.white.withOpacity(0.4),
                        ),
                        MessageField(),
                      ],
                    ),
                  ],
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   left: 0,
              //   right: 0,
              //   child: MessageField(),
              // ),
              Positioned(
                top: 20,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 70, // Limit the width
                    child: Header(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 23,
                    backgroundImage: AssetImage('images/profile.png'),
                  ),
                  SizedBox(width: 12,),
                  Text('User', style: appLabelTextStyle,),
                ],
              ),
            ),
            IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.cancel_outlined, color: purple4,),
            )
          ],
        ),
      ),
    );
  }
}

class MessageField extends StatelessWidget {
  const MessageField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final messageTextController = TextEditingController();
    String? messageText;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextField(
                  controller: messageTextController,
                  onChanged: (value) {
                    messageText = value;
                  },
                decoration: textFieldStyle
                ),
              ),
            SizedBox(width: 5,),
            ElevatedButton(
              onPressed: () {
                print('$messageText');
                messageTextController.clear();
              },
              child: Text(
                'Send',
                style: TextStyle(
                  color: purple4,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
