


import 'package:animated_application/features/presentation/pages/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class AnimatedBar extends StatelessWidget {
  final bool isActive;
  const AnimatedBar({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ?20 : 0,
      decoration: BoxDecoration(
          color: Color(0xFF81B4FF),
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}
