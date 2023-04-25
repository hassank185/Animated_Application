import 'package:animated_application/features/presentation/pages/home/components/course_cards.dart';
import 'package:animated_application/features/presentation/pages/home/components/secondary_course_card.dart';
import 'package:animated_application/features/presentation/pages/home/models/course_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...courses
                        .map((course) => CourseCards(
                              course: course,
                            ))
                        .toList(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Recent",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ...recentCourses.map((course) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: SecondaryCourseCard(course: course),
            ))
            ],
          ),
        ),
      ),
    );
  }
}
