import 'dart:async';
//import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path/path.dart' as Path;

import 'package:trapeazium/homepage.dart';

class splashView extends StatefulWidget {
  const splashView({Key? key}) : super(key: key);

  @override
  State<splashView> createState() => _splashViewState();
}


class _splashViewState extends State<splashView>

   with TickerProviderStateMixin {
  late final _slideAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );
  late final Animation<Offset> _slideAnimation =
      Tween<Offset>(begin: const Offset(0, -4), end: const Offset(0, 0))
          .animate(
    CurvedAnimation(
      parent: _slideAnimationController,
      curve: Curves.elasticInOut,
    ),
  );
  late final _fadeAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );
  late final Animation<double> _fadeAnimation = CurvedAnimation(
    parent: _fadeAnimationController,
    curve: Curves.easeInOut,
  );
  late final _scaleAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
    reverseDuration: const Duration(milliseconds: 444),
  );
  late final Animation<double> _scaleAnimation =
      Tween<double>(begin: 0.4, end: 4).animate(
    CurvedAnimation(
      parent: _scaleAnimationController,
      curve: Curves.elasticInOut,
    ),
  );
  @override
  void initState() {
    super.initState();
    _slideAnimationController.forward();
    _fadeAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 1721)).then((value) {
      _fadeAnimationController.reverse();
      _scaleAnimationController.forward();
    });
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const HOMEPAGE(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation.drive(Tween(begin: 0, end: 1)),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 871),
          reverseTransitionDuration: const Duration(milliseconds: 871),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _slideAnimationController.dispose();
    _fadeAnimationController.dispose();
    _scaleAnimationController.dispose();
    super.dispose();
  }

  Future<void> doSomeAsyncStuff() async {
    print("Splash :Before");
    Timer(Duration(seconds: 3), () async {
      Navigator.pushReplacement(
              this.context,
              MaterialPageRoute(
                  builder: (context) => HOMEPAGE()));
    });
    ;
    print("Splash :END");
  }

  
  @override
  Widget build(BuildContext context) {
    doSomeAsyncStuff();
    return Scaffold(
      body: Container(
       height: MediaQuery.of(context).size.height,
       width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: CupertinoColors.white,
        ),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Hero(
                tag: "splash",
                child: Image.asset(
                  scale: 0.1,
                  'assests/logo_trpeazium.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}