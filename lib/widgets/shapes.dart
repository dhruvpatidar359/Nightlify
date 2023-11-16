import 'dart:math';
import 'dart:math' as math;

import 'package:flutter/material.dart';

/*
This file consist of the widgets that are required to make this app night themed .
 */

// Cloud
// two types of clouds are there
// class CloudPainter extends CustomPainter {
//   CloudPainter(this.style, this.color, this.type);
//
//   PaintingStyle style;
//   Color color;
//   int type;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = color
//       ..style = style;
//
//     // Draw the cloud-like shape
//
//     // Here i have drawn a figure of cloud then i drew these points .
//     // You may also draw a cloud to verify this .
//
//     late Path path;
//
//     if (type == 1) {
//       path = Path()
//         ..moveTo(10, size.height)
//         ..quadraticBezierTo(size.width / 4, size.height + size.height / 4,
//             size.width / 1.5, size.height)
//         ..quadraticBezierTo(size.width, size.height + size.height / 2.5,
//             1.1 * size.width, size.height)
//         ..quadraticBezierTo(size.width + 20, size.height / 1.5,
//             size.width * 3 / 4, size.height / 2)
//         ..quadraticBezierTo(
//             size.width / 2, size.height / 7, size.width / 3, size.height / 2)
//         ..quadraticBezierTo(0, size.height / 2, 10, size.height);
//     } else if (type == 0) {
//       path = Path()
//         ..moveTo(10, size.height)
//         ..quadraticBezierTo(size.width / 4, size.height + size.height / 4,
//             size.width / 2, size.height)
//         ..quadraticBezierTo(size.width * 3 / 4, size.height + size.height / 3,
//             size.width, size.height)
//         ..quadraticBezierTo(size.width + 20, size.height / 2.5,
//             size.width * 3 / 4, size.height / 2)
//         ..quadraticBezierTo(
//             size.width / 2, size.height / 5, size.width / 3, size.height / 2)
//         ..quadraticBezierTo(0, size.height / 2, 10, size.height);
//     }
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

// Star for different purposes

class FourPointedStar extends StatefulWidget {
  FourPointedStar({
    Key? key,
    required this.color,
    required this.height,
    required this.width,
  }) : super(key: key);

  final Color color;
  final double height;
  final double width;

  @override
  _FourPointedStarState createState() => _FourPointedStarState();
}

class _FourPointedStarState extends State<FourPointedStar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _animationOpacity;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation =
        Tween<double>(begin: 0.8, end: 1.0).animate(_animationController);
    _animationOpacity =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            child: child,
            scale: _animation.value,
          );
        },
        child: ClipPath(
            clipper: StarClipper(5),
            child: Container(
              width: widget.height,
              height: widget.width,
              color: widget.color,
            )),
      ),
    );
  }
}

class StarClipper extends CustomClipper<Path> {
  /// The number of points of the star
  final int points;

  StarClipper(this.points);

  // Degrees to radians conversion
  double _degreeToRadian(double deg) => deg * (math.pi / 180.0);

  @override
  Path getClip(Size size) {
    Path path = Path();

    double max = 2 * math.pi;

    double width = size.width;
    double halfWidth = width / 2;

    double wingRadius = halfWidth;
    double radius = halfWidth / 2;

    double degreesPerStep = _degreeToRadian(360 / points);
    double halfDegreesPerStep = degreesPerStep / 2;

    path.moveTo(width, halfWidth);

    for (double step = 0; step < max; step += degreesPerStep) {
      path.lineTo(halfWidth + wingRadius * math.cos(step),
          halfWidth + wingRadius * math.sin(step));
      path.lineTo(halfWidth + radius * math.cos(step + halfDegreesPerStep),
          halfWidth + radius * math.sin(step + halfDegreesPerStep));
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    StarClipper starClipper = oldClipper as StarClipper;
    return points != starClipper.points;
  }
}

class BackGroundStarGlow extends StatefulWidget {
  BackGroundStarGlow({
    Key? key,
    required this.color,
    required this.height,
    required this.width,
  }) : super(key: key);

  final Color color;
  final double height;
  final double width;

  @override
  _BackGroundStarGlow createState() => _BackGroundStarGlow();
}

class _BackGroundStarGlow extends State<BackGroundStarGlow>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation =
        Tween<double>(begin: 0.8, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            child: child,
            scale: _animation.value,
          );
        },
        child: Container(
          width: widget.height,
          height: widget.width,
          decoration: BoxDecoration(
            color: widget.color,
            boxShadow: [
              BoxShadow(
                color: Colors.yellow,
                blurRadius: 20,
                spreadRadius: 10,
              ),
            ],
          ),
          child: ClipPath(
            clipper: StarClipper(5),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}

Widget glowStar(
    double height, double width, double glowHeight, double glowWidth) {
  return Stack(alignment: Alignment.center, children: [
    FourPointedStar(color: Colors.yellow, height: height, width: width),
    BackGroundStarGlow(
        color: Colors.transparent, height: glowHeight, width: glowWidth),
  ]);
}

Widget animatedStars(double x, double y) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      MultiAnimationStar(
          duration: 2, startf: 0.5, endf: -0.3, startl: x - 0.5, endl: y + 0.7),
      SizedBox(
        height: 2,
      ),
      MultiAnimationStar(
          duration: 3, startf: 0.5, endf: -0.3, startl: x - 0.4, endl: y + 0.7),
      SizedBox(
        height: 2,
      ),
      MultiAnimationStar(
          duration: 1, startf: 0.5, endf: -0.3, startl: x - 0.7, endl: y + 0.7),
      SizedBox(
        height: 2,
      ),
      MultiAnimationStar(
          duration: 5, startf: 0.5, endf: -0.3, startl: 0.0, endl: y + 0.7),
    ],
  );
}

// Stars with animations
class MultiAnimationStar extends StatefulWidget {
  MultiAnimationStar({
    Key? key,
    required this.duration,
    required this.startf,
    required this.endf,
    required this.startl,
    required this.endl,
  }) : super(key: key);

  final int duration;
  final double startf;
  final double endf;
  final double startl;
  final double endl;

  @override
  _MultiAnimationStarState createState() => _MultiAnimationStarState();
}

class _MultiAnimationStarState extends State<MultiAnimationStar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _moveAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _createAnimations();
  }

  void _createAnimations() {
    _controller = AnimationController(
      duration: Duration(seconds: widget.duration),
      vsync: this,
    );

    final CurvedAnimation moveCurve =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _moveAnimation = Tween<Offset>(
      begin: Offset(widget.startf, widget.endf),
      end: Offset(widget.startl, widget.endl),
    ).animate(moveCurve);

    _rotationAnimation = Tween(begin: 0.0, end: 2 * pi).animate(_controller);

    _fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(MultiAnimationStar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if any of the animation properties have changed
    if (widget.startf != oldWidget.startf ||
        widget.endf != oldWidget.endf ||
        widget.startl != oldWidget.startl ||
        widget.endl != oldWidget.endl) {
      // Dispose of the old controller
      _controller.dispose();
      // Recreate the animations with the new values
      _createAnimations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: _moveAnimation.value * MediaQuery.of(context).size.width,
              child: Transform.rotate(
                angle: _rotationAnimation.value,
                child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: glowStar(20, 20, 5, 5)),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class StaticStarOpacity extends StatefulWidget {
  StaticStarOpacity(
      {super.key,
      required this.height,
      required this.width,
      required this.glowHeight,
      required this.glowWidth,
      required this.duration});

  double height;
  double width;
  double glowHeight;
  double glowWidth;
  int duration;

  @override
  State<StaticStarOpacity> createState() => _StaticStarOpacityState();
}

class _StaticStarOpacityState extends State<StaticStarOpacity>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: widget.duration))
      ..repeat(reverse: true);

    animation = Tween(begin: 1.0, end: 0.0).animate(animationController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Opacity(
          opacity: animation.value,
          child: glowStar(widget.height, widget.width, widget.glowHeight,
              widget.glowWidth)),
    );
  }
}

class RandomStars extends StatefulWidget {
  @override
  _RandomStarsState createState() => _RandomStarsState();
}

class _RandomStarsState extends State<RandomStars> {
  List<Widget> stars = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    startGeneratingStars();
  }

  void startGeneratingStars() {
    int starsCount = 0;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    starsCount = (max(height, width) / min(height, width)).round() + 6;

    for (int i = 0; i < starsCount; i++) {
      final starSize = 20.0; // Random star size.
      final glowSize = 10.0;
      final x = Random().nextDouble() *
          (MediaQuery.of(context).size.width - starSize);
      final y = Random().nextDouble() *
          (MediaQuery.of(context).size.height - starSize);
      final duration = Random().nextInt(6) + 1;

      // Create and add a star to the list.

      stars.add(
        Positioned(
          top: y,
          left: x,
          child: StaticStarOpacity(
              height: starSize,
              width: starSize,
              glowHeight: glowSize,
              glowWidth: glowSize,
              duration: duration),
        ),
      );
    }

    setState(() {
      stars = List.from(stars); // Trigger a rebuild to add the new star.
    });

    // Schedule the removal of the last added star after 1 second.
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [for (var star in stars) star],
      ),
    );
  }
}
