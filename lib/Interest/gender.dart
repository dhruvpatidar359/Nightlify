import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nightlify/constants/appColors.dart';
import 'package:nightlify/widgets/shapes.dart';

class GenderAge extends StatefulWidget {
  const GenderAge({super.key});

  @override
  State<GenderAge> createState() => _GenderAgeState();
}

class _GenderAgeState extends State<GenderAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appBlack,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Animate(
            //   child: glowStar(),
            //   effects: [
            //     FollowPathEffect(
            //         path: getPath(), duration: Duration(seconds: 2)),
            //     FadeEffect(begin: 0, end: 1),
            //   ],
            //   onComplete: (controller) => controller.repeat(),
            // )
            MultiAnimationDemo(
                duration: 2, startf: 1.0, endf: -0.6, startl: -0.3, endl: 0.7),
            SizedBox(
              height: 2,
            ),

            MultiAnimationDemo(
                duration: 3, startf: 1.0, endf: -0.5, startl: -0.2, endl: 0.7),
            SizedBox(
              height: 2,
            ),
            MultiAnimationDemo(
                duration: 1, startf: 1.0, endf: -0.4, startl: -0.1, endl: 0.7),
            SizedBox(
              height: 2,
            ),
            MultiAnimationDemo(
                duration: 5, startf: 1.0, endf: -0.3, startl: 0.0, endl: 0.7),
          ],
        )
        // body: Stack(
        //   children: [
        //
        //   ],
        // )
        );
  }
}
