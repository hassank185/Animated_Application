import 'package:flutter/material.dart';

class CourseModel {
  final String title;
  final String description;
  final String iconSrc;
  final Color bgColor;
  CourseModel({
    this.bgColor = const Color(0xFF7553F6),
    required this.title,
    this.description = "Build and anumate an iOS app from scratch",
    this.iconSrc = "assets/icons/ios.svg",
  });
}

List<CourseModel> courses = [
  CourseModel(title: "Animations in SwiftUI"),
  CourseModel(
    title: "Animations in Flutter",
    iconSrc: "assets/icons/code.svg",
    bgColor: Color(0xFF80A4FF),
  )
];

List<CourseModel> recentCourses = [
  CourseModel(title: "State Machine"),
  CourseModel(
    title: "Animated Menu",
    iconSrc: "assets/icons/code.svg",
    bgColor: Color(0xFF9CC5FF),
  ),
  CourseModel(title: "Flutter with Rive"),
  CourseModel(
    title: "Animated Menu",
    iconSrc: "assets/icons/code.svg",
    bgColor: Color(0xFF9CC5FF),
  ),
];


