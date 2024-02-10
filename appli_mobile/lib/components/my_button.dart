import 'package:appli_mobile/decoration/constraints.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final VoidCallback onPressed;
  final Color background;
  final String fontFamily;
  const MyButton(
      {super.key,
      required this.text,
      required this.fontSize,
      this.background = couleurAffichage,
      this.fontFamily = 'Sniglet',
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
        child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(background),
      ),
      onPressed: () {
        onPressed();
      },
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              fontFamily: fontFamily),
        ),
      ),
    ));
  }
}
