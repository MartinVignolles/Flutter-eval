import 'package:flutter/material.dart';

class LogoBouton extends StatelessWidget {
  final VoidCallback onPressed;
  final String image;

  const LogoBouton({Key? key, required this.onPressed, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 3,
        padding: EdgeInsets.zero,
        shape: const CircleBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          image,
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}
