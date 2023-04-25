import 'package:animated_application/features/presentation/pages/main_screen/main_screen.dart';
import 'package:animated_application/state_machine_controller/state_machine_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger confetti;
  bool isConfetti = false;

  bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 620,
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.only(top: 32, left: 24, right: 24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.94),
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: _body(),
        ),
      ),
    );
  }
  _body(){
    return SingleChildScrollView(
      child: Column(
            children: [
              Text(
                "Sign In",
                style: TextStyle(fontSize: 34, fontFamily: "Poppins"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "Access to 240+ hours of content. Learn design and code, by building real apps with Flutter and Swift.",
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(color: Colors.black54),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "";
                          }
                          return null;
                        },
                        onSaved: (email) {},
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: SvgPicture.asset("assets/icons/email.svg"),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Password",
                      style: TextStyle(color: Colors.black54),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "";
                          }
                          return null;
                        },
                        onSaved: (password) {},
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: SvgPicture.asset("assets/icons/password.svg"),
                          ),
                        ),
                      ),
                    ),
                    _elevatedButton(),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "OR",
                            style: TextStyle(color: Colors.black26),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                          child: Text(
                            "Sign up with Email, Apple or Google ",
                            style: TextStyle(color: Colors.black54),
                          )),
                    ),
                    _bottomIconButtons(),
                  ],
                ),
              ),
              isLoading
                  ? _customPositioned(
                child: RiveAnimation.asset(
                  "assets/RiveAssets/check.riv",
                  onInit: (artboard) {
                    StateMachineController controller = RiveUtils.getRiveController(artboard);
                    check = controller.findSMI("Check") as SMITrigger;
                    error = controller.findSMI("Error") as SMITrigger;
                    reset = controller.findSMI("Reset") as SMITrigger;
                  },
                ),
              )
                  : SizedBox(),
              isConfetti
                  ? _customPositioned(
                child: Transform.scale(
                  scale: 7,
                  child: RiveAnimation.asset(
                    "assets/RiveAssets/confetti.riv",
                    onInit: (artboard) {
                      StateMachineController controller = RiveUtils.getRiveController(artboard);
                      confetti = controller.findSMI("Trigger explosion") as SMITrigger;
                    },
                  ),
                ),
              )
                  : SizedBox()
            ],
          ),
    );


  }

  _customPositioned({required child, double size = 100}) {
    return Positioned.fill(
      child: Column(
        children: [
          Spacer(),
          SizedBox(
            height: size,
            width: size,
            child: child,
          ),
          Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }

  _elevatedButton() {
    return   Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: ElevatedButton.icon(
          onPressed: () {
            setState(() {
              isLoading = true;
              isConfetti = true;
            });
            Future.delayed(Duration(seconds: 1), () {
              if (_formKey.currentState!.validate()) {
                check.fire();
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    isLoading = false;
                    confetti.fire();
                    Future.delayed(Duration(seconds: 1),(){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => MainScreen()));
                    });
                  });
                });
              } else {
                error.fire();
                Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    isLoading = false;
                  });
                });
              }
            });
          },
          style: ElevatedButton.styleFrom(
              primary: Color(0xFFF77D8E),
              minimumSize: Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              )),
          icon: Icon(
            CupertinoIcons.arrow_right,
            color: Colors.red,
          ),
          label: Text("Sign In")),
    );
  }

  _bottomIconButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/icons/email_box.svg",
            height: 64,
            width: 64,
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/icons/apple_box.svg",
            height: 64,
            width: 64,
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/icons/google_box.svg",
            height: 64,
            width: 64,
          ),
        ),
      ],
    );
  }
}

//This is how the cubit works and t
