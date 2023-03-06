import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Courses",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Container(
              height: 280,
                width: 260,
              decoration: BoxDecoration(
                color: Color(0xFF80A4FF),
                borderRadius: BorderRadius.circular(30),
              ),
            )
          ],
        ),
      ),
    );
  }
}
