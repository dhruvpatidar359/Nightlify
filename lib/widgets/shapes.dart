import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

/*
This file consist of the widgets that are required to make this app night themed .
 */

// Cloud

class CloudPainter extends CustomPainter {
  CloudPainter(this.style, this.color);

  PaintingStyle style;
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = style;

    // Draw the cloud-like shape

    // Here i have drawn a figure of cloud then i drew these points .
    // You may also draw a cloud to verify this .
    final path = Path()
      ..moveTo(10, size.height)
      ..lineTo(size.width, size.height)
      ..quadraticBezierTo(size.width + 20, size.height / 1.5,
          size.width * 3 / 4, size.height / 2)
      ..quadraticBezierTo(
          size.width / 2, size.height / 20, size.width / 3, size.height / 2)
      ..quadraticBezierTo(0, size.height / 2, 10, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

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
                color: Colors.white, // Glow color
                blurRadius:
                    20, // Adjust the blur radius for the desired glow effect
                spreadRadius:
                    10, // Adjust the spread radius for the desired glow effect
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

class AnimatedStar extends StatefulWidget {
  const AnimatedStar({super.key});

  @override
  State<AnimatedStar> createState() => _AnimatedStarState();
}

class _AnimatedStarState extends State<AnimatedStar> {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Widget glowStar() {
  return Stack(alignment: Alignment.center, children: [
    FourPointedStar(color: Colors.white, height: 20, width: 20),
    BackGroundStarGlow(color: Colors.transparent, height: 5, width: 5),
  ]);
}

class MultiAnimationDemo extends StatefulWidget {
  MultiAnimationDemo(
      {required this.duration,
      required this.startf,
      required this.endf,
      required this.startl,
      required this.endl});

  int duration;
  double startf;
  double endf;
  double startl;
  double endl;

  @override
  _MultiAnimationDemoState createState() => _MultiAnimationDemoState();
}

class _MultiAnimationDemoState extends State<MultiAnimationDemo>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _moveAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Create an AnimationController to control the animations
    _controller = AnimationController(
      duration: Duration(seconds: widget.duration),
      vsync: this,
    );

    // Create a curved animation for smooth movement
    final CurvedAnimation moveCurve =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // Adjust the starting position and movement for the shooting star
    _moveAnimation = Tween<Offset>(
      begin: Offset(widget.startf, widget.endf), // Start from the right
      end: Offset(widget.startl, widget.endl), // Move diagonally to the left
    ).animate(moveCurve);

    // Create a rotation animation
    _rotationAnimation = Tween(begin: 0.0, end: 2 * pi).animate(_controller);

    // Create a fade animation
    _fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(_controller);

    // Start the animation and repeat it indefinitely

    _controller.repeat();
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
                child:
                    Opacity(opacity: _fadeAnimation.value, child: glowStar()),
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
