import 'package:flutter/material.dart';
import 'package:flutter_uberclone/components/fading_sliding_widget.dart';

class Onboardfirstpage extends StatefulWidget {
  @override
  static const String idScreen="firstOnboard";
  _Onboardfirstpagetate createState() => _Onboardfirstpagetate();
}

class _Onboardfirstpagetate extends State<Onboardfirstpage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Positioned.fill(
          child:Container(color: Color(0xff8c8c8c),
           child: Image.asset("images/welcome.png",scale: 0.9,),
          )
        ),

//         Positioned(
//           child: Container(
//             height: width * 0.1,
//             width: width * 0.1,
//             decoration: ShapeDecoration(
//                 shape: CircleBorder(),
//                 gradient: LinearGradient(
//                   colors: [
////                     const Color(0xFF00FFDC),
//                     const Color(0xFF5096FE),
//                   ],
//                 )),
//           ),
//            top: 100,
//           left: 20,
//         ),
        Positioned(
          top: height * 0.1,
          child: Column(

            children: <Widget>[
               ScaleTransition(
                 scale: _animationController.drive(
                   Tween<double>(begin: 0.3, end: 1.0).chain(
                     CurveTween(
                       curve: Interval(0.0, 0.2, curve: Curves.elasticInOut),
                     ),
                   ),
                 ),
                 child: FadeTransition(
                   opacity: _animationController.drive(
                     Tween<double>(begin: 0.0, end: 1.0).chain(
                       CurveTween(
                         curve: Interval(0.2, 0.4, curve: Curves.decelerate),
                       ),
                     ),
                   ),
                   child: ScaleTransition(
                     scale: _animationController.drive(
                       Tween<double>(begin: 1.3, end: 1.0).chain(
                         CurveTween(
                           curve: Interval(0.2, 0.4, curve: Curves.elasticInOut),
                         ),
                       ),
                     ),
                     child: Container(
                       width: width * 0.3,
                       height: width * 0.3,
                       decoration: ShapeDecoration(
                         color: const Color(0xFFFFFFFF),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(width * 0.08),
                         ),
                       ),
                       child: Image.asset(
                      'images/logo1.png',
                         scale: 0.9,
                       ),
                     ),
                   ),
                 ),
               ),
              SizedBox(
                height: height * 0.04,
              ),
//              FadingSlidingWidget(
//                animationController: _animationController,
//                interval: const Interval(0.5, 0.9),
//                child: Text(
//                  'Zoomie',
//                  style: TextStyle(
//                    color: const Color(0xFFFFFFFF),
//                    fontSize: width * 0.08,
////                    fontFamily: 'ProductbSans',
//                  ),
//                ),
//              ),
              SizedBox(
                height: height * 0.5,
              ),
              Container(
                width: width * 0.9,
                child: FadingSlidingWidget(
                  animationController: _animationController,
                  interval: const Interval(0.7, 1.0),
                  child: Text(
                    'Find your Ride now',
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: width * 0.056,
//                      fontFamily: 'ProductSans',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
