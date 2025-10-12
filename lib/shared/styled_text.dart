import 'package:flutter/material.dart';
import 'package:temuin_app/theme.dart';

class GradientText extends StatelessWidget {
  const GradientText({super.key, required this.text});

  final Text text;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [CustomColors.blueGradient, CustomColors.purpleGradient],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(bounds);
      },
      child: text,
    );
  }
}
