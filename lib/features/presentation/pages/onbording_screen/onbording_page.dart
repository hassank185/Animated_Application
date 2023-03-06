import 'dart:ui';

import 'package:animated_application/features/presentation/pages/credentials/sign_in_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  bool isSignInDialog = false;
  late RiveAnimationController _btnAnimationController;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation("active", autoplay: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery
                .of(context)
                .size
                .width * 1.7,
            bottom: 200,
            left: 100,
            child: Image.asset("assets/Backgrounds/Spline.png"),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 20,
                sigmaY: 10,
              ),
            ),
          ),
          RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 30,
                sigmaY: 30,
              ),
              child: SizedBox(),
            ),
          ),
          AnimatedPositioned(
            top: isSignInDialog == true ? -50 : 0,
            duration: Duration(milliseconds: 400),
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          "Learn design         & code",
                          style: TextStyle(fontSize: 55, fontFamily: "Poppins", height: 1.2),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                            "Don't skip design. Learn design and code, by building real apps with Flutter and Swift. Complete courses about the best tools"),
                      ],
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    _animatedButton(
                        btnAnimationController: _btnAnimationController,
                        press: () {
                          _btnAnimationController.isActive = true;
                          Future.delayed(
                            Duration(milliseconds: 400),
                                () {
                              setState(() {
                                isSignInDialog = true;
                              });
                              customSignInDialog(
                                  context,
                                  onClosed: (_) {
                                    setState(() {
                                      isSignInDialog = false;
                                    });
                                  }
                              );
                            },
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child:
                      Text("Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates,"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _animatedButton({
    required RiveAnimationController btnAnimationController,
    required VoidCallback press,
  }) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        height: 64,
        width: 260,
        child: Stack(
          children: [
            RiveAnimation.asset(
              "assets/RiveAssets/button.riv",
              controllers: [_btnAnimationController],
            ),
            Positioned.fill(
              top: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.arrow_right),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Start the course",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Object?> customSignInDialog(BuildContext context, {required ValueChanged onClosed}) {
    return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Sign In",
      context: context,
      transitionDuration: Duration(milliseconds: 800),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween;
        tween = Tween(begin: Offset(0, -1), end: Offset.zero);
        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      },
      pageBuilder: (context, _, __) => SignInForm(),
    ).then((onClosed));
  }
}
