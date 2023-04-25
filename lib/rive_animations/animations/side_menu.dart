import 'package:animated_application/rive_animations/models/rive_assets.dart';
import 'package:animated_application/state_machine_controller/state_machine_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 280,
        height: double.infinity,
        color: Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            children: [
              _infoCard(
                name: 'Muhammad Hassan',
                profession: "Flutter Developer",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32, left: 24, bottom: 16),
                child: Text(
                  "BROWSE",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white70),
                ),
              ),
              ...sideMenus.map(
                (menu) => _SideMenuTile(
                  menu: menu,
                  riveOnInit: (artboard){
                   StateMachineController controller =
                      RiveUtils.getRiveController(artboard,stateMachine: menu.stateMachineName);
                   menu.input = controller.findSMI("active") as SMIBool;
                  },
                  press: (){
                     menu.input!.change(true);
                  },
                  isActive: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _infoCard({required String name, profession}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(profession, style: TextStyle(color: Colors.white)),
    );
  }

  _SideMenuTile({
    required RiveAsset menu,
    required VoidCallback press,
    required ValueChanged<Artboard> riveOnInit,
    required bool isActive,
  }) {
    return Column(
      children: [
        Divider(
          color: Colors.white24,
          height: 1,
        ),
        ListTile(
            onTap: press,
            leading: SizedBox(
              height: 34,
              width: 34,
              child: RiveAnimation.asset(
                menu.src,
                artboard: menu.artboard,
                onInit: riveOnInit,
              ),
            ),
            title: Text(
              menu.title,
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }
}
