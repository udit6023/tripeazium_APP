import 'dart:async';
//import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripeazium/CONFIG.dart/CONFIG.dart';
import 'package:tripeazium/views/HomeScreen.dart';

import 'package:tripeazium/views/LoginScreen.dart';
import 'package:tripeazium/services/shared_prefrences.dart';
import 'package:tripeazium/views/dropDownPage.dart';

class splashView extends StatefulWidget {
  const splashView({Key? key}) : super(key: key);

  @override
  State<splashView> createState() => _splashViewState();
}


class _splashViewState extends State<splashView>

   {
  // late final _slideAnimationController = AnimationController(
  //   vsync: this,
  //   duration: const Duration(seconds: 1),
  // );
  // late final Animation<Offset> _slideAnimation =
  //     Tween<Offset>(begin: const Offset(0, -4), end: const Offset(0, 0))
  //         .animate(
  //   CurvedAnimation(
  //     parent: _slideAnimationController,
  //     curve: Curves.elasticInOut,
  //   ),
  // );
  // late final _fadeAnimationController = AnimationController(
  //   vsync: this,
  //   duration: const Duration(seconds: 1),
  // );
  // late final Animation<double> _fadeAnimation = CurvedAnimation(
  //   parent: _fadeAnimationController,
  //   curve: Curves.easeInOut,
  // );
  // late final _scaleAnimationController = AnimationController(
  //   vsync: this,
  //   duration: const Duration(milliseconds: 1500),
  //   reverseDuration: const Duration(milliseconds: 444),
  // );
  // late final Animation<double> _scaleAnimation =
  //     Tween<double>(begin: 0.4, end: 4).animate(
  //   CurvedAnimation(
  //     parent: _scaleAnimationController,
  //     curve: Curves.elasticInOut,
  //   ),
  // );
  @override
  void initState() {
    super.initState();
    
    // _slideAnimationController.forward();
    // _fadeAnimationController.forward();
    // Future.delayed(const Duration(milliseconds: 1721)).then((value) {
    //   _fadeAnimationController.reverse();
    //   _scaleAnimationController.forward();
    // });
    // Future.delayed(const Duration(seconds: 2)).then(
    //   (value) => Navigator.pushReplacement(
    //     context,
    //     PageRouteBuilder(
    //       pageBuilder: (context, animation, secondaryAnimation) => const HOMEPAGE(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(
    //           opacity: animation.drive(Tween(begin: 0, end: 1)),
    //           child: child,
    //         );
    //       },
    //       transitionDuration: const Duration(milliseconds: 871),
    //       reverseTransitionDuration: const Duration(milliseconds: 871),
    //     ),
    //   ),
    // );
  }
  @override
  void dispose() {
    // _slideAnimationController.dispose();
    // _fadeAnimationController.dispose();
    // _scaleAnimationController.dispose();
    super.dispose();
  }

 Future<void> doSomeAsyncStuff() async {
    print("Splash :Before");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Timer(Duration(seconds: 2), () async {
      print("Splash :After");
      bool is_login=await SharePreference.getBooleanValue(CONFIG.IS_LOGIN);
      print(is_login);
  String phnnumber=await SharePreference.getStringValue(CONFIG.USER_PHONENUMBER);
  print(phnnumber);
      if (is_login==true) {
        if (await SharePreference.getStringValue(CONFIG.USER_TYPE) ==phnnumber
            ) {
             
                 print("chal ja bsdk");
                Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => dropDown()));
          
        }
      } else {
      
           Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => dropDown()));
       
      }
    });
    print("Splash :END");
  }

  
  @override
  Widget build(BuildContext context) {
    doSomeAsyncStuff();
    return Scaffold(
      body: Center(
        child: Container(
         height: MediaQuery.of(context).size.height/2,
         width: MediaQuery.of(context).size.width/2,
          decoration: BoxDecoration(
            
          ),
                child: Hero(
                  tag: "splash",
                  child: Image.asset(
                    scale: 0.1,
                    'assests/logo_trpeazium.png'),
                ),
            
            ),
      ),
    );
  }
}