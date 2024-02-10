import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String hintText;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;

  const MyText(
      {super.key,
      required this.hintText,
      required this.fontSize,
      this.fontFamily = 'Sniglet',
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Text(
        hintText,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
