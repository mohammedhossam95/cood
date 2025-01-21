import 'package:flutter/material.dart';

class WelcomeData {
  int? id;
  String? title;
  String? details;
  String? image;
  Color? color;

  WelcomeData({
    this.id,
    this.title,
    this.details,
    this.image,
    this.color,
  });
}

List<WelcomeData> pages = [
  WelcomeData(
    id: 1,
    title: 'title1',
    details: 'details1',
  ),
  WelcomeData(
    id: 2,
    title: 'title2',
    details: 'details1',
  ),
  WelcomeData(
    id: 3,
    title: "title3",
    details: 'details1',
  ),
];
