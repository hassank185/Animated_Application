


import 'package:rive/rive.dart';

class RiveUtils {
  static StateMachineController getRiveController(Artboard artboard,{stateMachine = "State Machine 1"}) {
    StateMachineController? controller =
    StateMachineController.fromArtboard(artboard, stateMachine );
    artboard.addController(controller!);
    return controller;
  }
}