import 'package:flutter/material.dart';
import 'package:nightlify/constants/constants.dart';

import '../../user/profile/profile.dart';
import '../../widgets/navigation.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.appBlack,
        body: SafeArea(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.map,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.emoji_events,
                      color: Colors.white,
                    )),
                GestureDetector(
                  onTap: () {
                    nextScreen(context, UserProfile());
                  },
                  child: CircleAvatar(
                    radius: 20,
                    child: Container(),
                  ),
                )
              ],
            ),
          )
        ])));
  }
}
