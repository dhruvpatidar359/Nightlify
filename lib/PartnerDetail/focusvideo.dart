import 'package:flutter/material.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:video_player/video_player.dart';

class FocusVideo extends StatefulWidget {
  const FocusVideo({super.key});

  @override
  State<FocusVideo> createState() => _FocusVideoState();
}

class _FocusVideoState extends State<FocusVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/whatsappclone-588c8.appspot.com/o/profile_pic%2FWhatsApp%20Video%202023-10-28%20at%203.09.51%20PM.mp4?alt=media&token=fb993543-c8fa-4690-b567-7965b2f37bd0'))
      ..initialize().then((_) {
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
      body: GestureDetector(
          onTap: () {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          },
          child: Center(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          )),
    );
  }
}
