import 'package:flutter/material.dart';

import 'constraints.dart';

class GradientContainer {
  static BoxDecoration blueGradient = BoxDecoration(
    gradient: const LinearGradient(
      colors: [
        couleurMaxGradient,
        couleurMinGradient,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    borderRadius: BorderRadius.circular(12.0),
  );
}
