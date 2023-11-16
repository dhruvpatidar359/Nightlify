import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nightlify/PartnerDetail/zoomphoto.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:video_player/video_player.dart';

class PartnerDetail extends StatefulWidget {
  const PartnerDetail({super.key});

  @override
  State<PartnerDetail> createState() => _PartnerDetailState();
}

class _PartnerDetailState extends State<PartnerDetail> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/whatsappclone-588c8.appspot.com/o/profile_pic%2FWhatsApp%20Video%202023-10-28%20at%203.09.51%20PM.mp4?alt=media&token=fb993543-c8fa-4690-b567-7965b2f37bd0'))
      ..initialize().then((_) {
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.appBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Animate(
                      effects: [
                        FadeEffect(begin: 0.0, end: 1.0, curve: Curves.easeIn),
                        SlideEffect(
                            begin: Offset(0, 0.01),
                            curve: Curves.easeIn,
                            duration: 1000.ms)
                      ],
                      child: Container(
                        height: Constants.h / 1.2,
                        width: Constants.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          // image: DecorationImage(
                          //   image: AssetImage("assets/images/woman1.jpg"),
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CachedNetworkImage(
                              imageUrl:
                                  'https://firebasestorage.googleapis.com/v0/b/whatsappclone-588c8.appspot.com/o/profile_pic%2Fpexels-athena-1758144.jpg?alt=media&token=9ca51a83-3b63-4235-a547-2d45d8cbde29',
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Animate(
                      effects: [
                        FadeEffect(begin: 0.0, end: 1.0, duration: 1000.ms)
                      ],
                      child: Positioned.fill(
                          bottom: Constants.h / 10,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(400),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaY: 15, sigmaX: 15),
                                    child: Container(
                                      height: Constants.h / 14,
                                      width: Constants.h / 14,
                                      color: Colors.black.withOpacity(0.4),
                                      child: Center(
                                        child: Icon(
                                          CupertinoIcons.video_camera_solid,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(400),
                                  child: Container(
                                    height: Constants.h / 14,
                                    width: Constants.h / 14,
                                    color: Constants.appBlue,
                                    child: Center(
                                      child: Icon(
                                        CupertinoIcons.chat_bubble_text_fill,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Dhruv Lives in",
                            style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ],
                      ).animate(effects: [
                        FadeEffect(begin: 0.0, end: 1.0, duration: 1000.ms),
                        SlideEffect(
                            begin: Offset(0, 1.0),
                            end: Offset(0, 0.0),
                            duration: 500.ms,
                            curve: Curves.easeIn)
                      ]),
                      Text(
                        "MP, India(Bharat)",
                        style: GoogleFonts.nunito(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ).animate(delay: 500.ms, effects: [
                        FadeEffect(begin: 0.0, end: 1.0, duration: 1000.ms),
                        SlideEffect(
                            begin: Offset(0, 1.0),
                            end: Offset(0, 0.0),
                            duration: 600.ms,
                            curve: Curves.easeIn)
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      Ink(
                        decoration: BoxDecoration(
                          color: Constants.appGrey, // Background color
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the border radius as needed
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4), // Adjust padding as needed
                          child: Text(
                            "from India Itself",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Text(
                  "Dhruv's Info",
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 5,
                  children: List.generate(
                      5,
                      (index) => Chip(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            avatar: Icon(
                              Icons.woman,
                              color: Colors.white,
                            ),
                            color: MaterialStatePropertyAll(Constants.appGrey),
                            label: Text('Women',
                                style: GoogleFonts.nunito(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white60)),
                          )),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("About Me",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "i love you and even every one in this world , there is kindness in everyone 🥳♥",
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white60),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Dhruv's Interests",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 5,
                  children: List.generate(
                      5,
                      (index) => Chip(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            avatar: Icon(
                              Icons.woman,
                              color: Colors.white,
                            ),
                            color: MaterialStatePropertyAll(Constants.appGrey),
                            label: Text('Women',
                                style: GoogleFonts.nunito(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white60)),
                          )),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    },
                    child: Container(
                      height: Constants.h / 1.2,
                      width: Constants.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: FittedBox(
                          fit: BoxFit.cover, // Set the desired fit
                          child: SizedBox(
                            width: _controller.value.size?.width ?? 0,
                            height: _controller.value.size?.height ?? 0,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 1000),
                          reverseTransitionDuration:
                              Duration(milliseconds: 1000), // Delay of 1000ms
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return ZoomPhoto(
                                tag: 3,
                                url:
                                    'https://firebasestorage.googleapis.com/v0/b/whatsappclone-588c8.appspot.com/o/profile_pic%2Fpexels-athena-1758144.jpg?alt=media&token=9ca51a83-3b63-4235-a547-2d45d8cbde29');
                          },
                        ));
                  },
                  child: Hero(
                    tag: 3,
                    child: Container(
                      height: Constants.h / 1.8,
                      width: Constants.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        // image: DecorationImage(
                        //   image: AssetImage("assets/images/woman1.jpg"),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: CachedNetworkImage(
                            imageUrl:
                                'https://firebasestorage.googleapis.com/v0/b/whatsappclone-588c8.appspot.com/o/profile_pic%2Fpexels-athena-1758144.jpg?alt=media&token=9ca51a83-3b63-4235-a547-2d45d8cbde29',
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 1000),
                          reverseTransitionDuration:
                              Duration(milliseconds: 1000), // Delay of 1000ms
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return ZoomPhoto(
                                tag: 2,
                                url:
                                    'https://firebasestorage.googleapis.com/v0/b/whatsappclone-588c8.appspot.com/o/profile_pic%2Fpexels-athena-1758144.jpg?alt=media&token=9ca51a83-3b63-4235-a547-2d45d8cbde29');
                          },
                        ));
                  },
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: 2,
                    child: Container(
                      height: Constants.h / 1.8,
                      width: Constants.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        // image: DecorationImage(
                        //   image: AssetImage("assets/images/woman1.jpg"),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: CachedNetworkImage(
                            imageUrl:
                                'https://firebasestorage.googleapis.com/v0/b/whatsappclone-588c8.appspot.com/o/profile_pic%2Fpexels-athena-1758144.jpg?alt=media&token=9ca51a83-3b63-4235-a547-2d45d8cbde29',
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
