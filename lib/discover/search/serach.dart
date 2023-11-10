import 'package:flutter/material.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:nightlify/user/profile/profile.dart';
import 'package:nightlify/widgets/navigation.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
