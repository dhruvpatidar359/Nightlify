import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nightlify/Interest/init.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:nightlify/details/interest.dart';
import 'package:nightlify/details/profileMini.dart';
import 'package:nightlify/discover/discover.dart';
import 'package:nightlify/discover/twoDScrollableGrid.dart';
import 'package:nightlify/login/login.dart';
import 'package:nightlify/widgets/card.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Animate.restartOnHotReload = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Constants.h = MediaQuery.sizeOf(context).height;
    Constants.w = MediaQuery.sizeOf(context).width;
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: GoogleFonts.nunitoSansTextTheme()),
        debugShowCheckedModeBanner: false,
        home: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent, //i like transaparent :-)
            systemNavigationBarColor: Colors.black, // navigation bar color
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(backgroundColor: Colors.black, body: MatrixMatch()),
        ));
  }
}
