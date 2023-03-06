import 'package:animated_application/constant.dart';
import 'package:animated_application/features/presentation/pages/home/home_page.dart';
import 'package:animated_application/rive_animations/animations/animated_bar_widget.dart';
import 'package:animated_application/rive_animations/models/rive_assets.dart';
import 'package:animated_application/state_machine_controller/state_machine_controller.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  RiveAsset selectedBottomNav = bottomNavs.first;
  late SMIBool searchTrigger;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(color: backgroundColor2.withOpacity(0.8), borderRadius: BorderRadius.all(Radius.circular(24))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              bottomNavs.length,
              (index) => GestureDetector(
                onTap: () {
                  bottomNavs[index].input!.change(true);
                  if (bottomNavs[index] != selectedBottomNav) {
                    setState(() {
                      selectedBottomNav = bottomNavs[index];
                    });
                  }
                  Future.delayed(Duration(seconds: 1), () {
                    bottomNavs[index].input!.change(false);
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBar(isActive: bottomNavs[index] == selectedBottomNav),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Opacity(
                        opacity: bottomNavs[index] == selectedBottomNav ? 1 : 0.5,
                        child: RiveAnimation.asset(
                          bottomNavs.first.src,
                          artboard: bottomNavs[index].artboard,
                          onInit: (artboard) {
                            StateMachineController controller =
                              RiveUtils.getRiveController(artboard, stateMachine: bottomNavs[index].stateMachineName);
                            bottomNavs[index].input = controller.findSMI("active") as SMIBool;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

