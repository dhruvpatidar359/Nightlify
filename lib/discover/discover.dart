import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:nightlify/discover/bloc/discover_bloc.dart';
import 'package:nightlify/discover/matrixmatch.dart';
import 'package:nightlify/discover/pair/pairs.dart';
import 'package:nightlify/discover/swipe.dart';
import 'package:random_avatar/random_avatar.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.appBlack,
      body: BlocBuilder<DiscoverBloc, DiscoverState>(
        builder: (context, state) {
          switch (state.props.first as int) {
            case 0:
              return Container(
                color: Colors.white,
              );
            case 1:
              return MatrixMatch();
            case 2:
              return Container(
                child: Center(child: Text("Coming soon")),
              );
            case 3:
              return SwipeMatch();

            case 4:
              return Pairs();
            default:
              return Container();
          }
        },
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BlocBuilder<DiscoverBloc, DiscoverState>(
          builder: (context, state) => BottomNavigationBar(
            backgroundColor: Constants.appBlack,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 5,
            selectedItemColor: Constants.appBlue,
            currentIndex: state.props.first as int,
            onTap: (value) {
              _selectedIndex = value;
              context.read<DiscoverBloc>().add(ChangePageEvent(value));
            },
            items: [
              BottomNavigationBarItem(
                  tooltip: "search",
                  activeIcon: Icon(
                    CupertinoIcons.search,
                    color: Constants.appBlue,
                  ),
                  icon: Icon(
                    CupertinoIcons.search,
                    color: Colors.white,
                  ),
                  backgroundColor: Constants.appBlack,
                  label: ""),
              BottomNavigationBarItem(
                  tooltip: "matrix match",
                  activeIcon: SvgPicture.asset(
                    height: 20,
                    width: 20,
                    color: Constants.appBlue,
                    "assets/icon/matrix_match.svg",
                  ),
                  icon: SvgPicture.asset(
                    height: 20,
                    width: 20,
                    "assets/icon/matrix_match.svg",
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  tooltip: "chats",
                  activeIcon: Icon(
                    FontAwesomeIcons.message,
                    color: Constants.appBlue,
                  ),
                  icon: Icon(
                    FontAwesomeIcons.message,
                    color: Colors.white,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  tooltip: "swipe",
                  activeIcon: SvgPicture.asset(
                    height: 30,
                    width: 30,
                    color: Constants.appBlue,
                    "assets/icon/swipe_card.svg",
                  ),
                  icon: SvgPicture.asset(
                    height: 30,
                    width: 30,
                    "assets/icon/swipe_card.svg",
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  tooltip: "pairs",
                  activeIcon: Icon(
                    CupertinoIcons.heart,
                    color: Constants.appBlue,
                  ),
                  icon: Icon(
                    CupertinoIcons.heart,
                    color: Colors.white,
                  ),
                  label: ""),
            ],
          ),
        ),
      ),
    );
  }
}
