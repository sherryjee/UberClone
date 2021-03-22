import 'package:flutter/material.dart';
import 'package:flutter_uberclone/all_screens/LoginScreen.dart';
import 'package:flutter_uberclone/all_screens/Onboardfirstpage.dart';
import 'package:flutter_uberclone/all_screens/Onboardpage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_uberclone/components/fading_sliding_widget.dart';

import 'package:flutter_uberclone/model/onboard_page_item.dart';

import 'package:get/get.dart';
class Onboard extends StatefulWidget {
  static const String idScreen="Onboard";
  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> with SingleTickerProviderStateMixin {

  List<OnboardPageItem> onboardPageItems = [
    OnboardPageItem(
      lottieAsset: 'assets/Animations/taxi-location-animation.json',
      text: 'See Nearest taxi  around you',
    ),
  ];

  PageController _pageController;

  List<Widget> onboardItems = [];
  double _activeIndex;
  bool onboardPage = false;
  AnimationController _animationController;

  @override
  void initState() {
    initializePages(); //initialize pages to be shown
    _pageController = PageController();
    _pageController.addListener(() {
      _activeIndex = _pageController.page;
      print("Active Index: $_activeIndex");
      if (_activeIndex >= 3.0 && onboardPage == false) {
        setState(() {
          onboardPage = true;
        });
      } else if (_activeIndex < 3.0) {
        setState(() {
          onboardPage = false;
        });
      }
    });
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..forward();
    super.initState();
  }

  initializePages() {
    onboardItems.add(Onboardfirstpage()); // welcome page
    onboardPageItems.forEach((onboardPageItem) {
      //adding onboard pages
      onboardItems.add(OnboardPage(
        onboardPageItem: onboardPageItem,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(
            child: PageView(
              controller: _pageController,
              children: onboardItems,
            ),
          ),

          Positioned(
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, Login_screen.idScreen, (route) => false);
              },
              child: FadingSlidingWidget(
                animationController: _animationController,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  alignment: Alignment.center,
                  width: width * 0.8,
                  height: height * 0.075,
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: onboardPage
                          ? const Color(0xFFFFFFFF)
                          : const Color(0xFF220555),
                      fontSize: width * 0.05,
//                      fontFamily: 'ProductSans',
                    ),
                  ),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 0.1),
                    ),
                    gradient: LinearGradient(
                      colors: onboardPage
                          ? [
                        const Color(0xffff0000),
                        const Color(0xFFFF3264),
                      ]
                          : [
                   const Color(0xFFffff00),
                       const Color(0xFFbcbcbc),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
