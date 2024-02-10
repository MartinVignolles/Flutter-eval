import 'package:flutter/material.dart';

class MyTextCircle extends StatelessWidget {
  final String hintText;
  final double fontSize;
  final Color color;
  final Color colorText;

  const MyTextCircle(
      {super.key,
      required this.hintText,
      required this.fontSize,
      this.color = Colors.white,
      this.colorText = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Text(
              hintText,
              style: TextStyle(
                fontFamily: 'Sniglet',
                fontSize: fontSize,
                color: colorText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
