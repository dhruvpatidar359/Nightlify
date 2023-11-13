import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nightlify/Interest/init.dart';
import 'package:nightlify/auth/bloc/auth_bloc.dart';
import 'package:nightlify/auth/data/authRepository/authentication_repository.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:nightlify/details/media/bloc/media_bloc.dart';
import 'package:nightlify/details/media/data/mediaRepository/mediaRepository.dart';
import 'package:nightlify/discover/bloc/discover_bloc.dart';
import 'package:nightlify/discover/discover.dart';
import 'package:nightlify/firebase/data/firestoreRepository/firestore_repository.dart';
import 'package:nightlify/user/profilebloc/profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Animate.restartOnHotReload = true;

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Obtain shared preferences.
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool isLogged = firebaseAuth.currentUser == null ? false : true;

  if (!isLogged) {
    await prefs.setString('gender', "Men");
    await prefs.setString("age", "0-99");
    await prefs.setString('name', "");
    await prefs.setString('username', "");
    await prefs.setStringList("interests", []);
    await prefs.setBool("values", false);
  }

  runApp(MyApp(screen: isLogged == true ? Discover() : InitClass()));
}

class MyApp extends StatelessWidget {
  MyApp({required this.screen});

  final screen;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Constants.h = MediaQuery.sizeOf(context).height;
    Constants.w = MediaQuery.sizeOf(context).width;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (BuildContext context) {
          return AuthRepository();
        }),
        RepositoryProvider(create: (BuildContext context) {
          return FirestoreRepository();
        }),
        RepositoryProvider(create: (BuildContext context) {
          return MediaRepository();
        }),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) {
            return AuthBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context));
          }),
          BlocProvider(
            create: (context) {
              return MediaBloc(
                  mediaRepository:
                      RepositoryProvider.of<MediaRepository>(context));
            },
          ),
          BlocProvider(
            create: (context) {
              return DiscoverBloc();
            },
          ),
          BlocProvider(
            create: (context) {
              return ProfileBloc(
                  fireStoreRepository:
                      RepositoryProvider.of<FirestoreRepository>(context));
            },
          ),
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              textSelectionTheme: TextSelectionThemeData(
                  selectionHandleColor: Constants.appBlue),
              textTheme: TextTheme(
                bodySmall: GoogleFonts.nunito(
                    color: Colors.white60,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
                bodyMedium: GoogleFonts.nunito(
                    color: Colors.white60,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                titleSmall: GoogleFonts.nunito(
                    color: Colors.white60,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                bodyLarge: GoogleFonts.nunito(
                    color: Colors.white60,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                titleMedium: GoogleFonts.nunito(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
                titleLarge: GoogleFonts.nunito(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
              fontFamily: GoogleFonts.nunito().fontFamily,
            ),
            debugShowCheckedModeBanner: false,
            home: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  systemNavigationBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light,
                  systemNavigationBarIconBrightness: Brightness.light,
                ),
                child: screen)),
      ),
    );
  }
}
