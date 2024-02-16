import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_lily/screens/chatroom.dart';

import '../Data/Users.dart';
import '../constants.dart';

class ContactCard extends StatelessWidget {
  ContactCard({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Chatroom.id);
            },
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(
                      'images/profile.png',
                    ), // retrieve from firebase?
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    Users.username,
                    style: appLabelTextStyle,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_vert_rounded),
            color: purple4,
            onPressed: () {
              print('more option tapped');
            },
          ),
        ],
      ),
    );
  }
}

