import 'package:flutter/material.dart';
import 'package:test_movie/app/resources/app_colors.dart';

class HorizontalProgressBar extends StatelessWidget {
  const HorizontalProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 3,
      child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(primary()),
      ),
    );
  }
}

class CircularProgressBar extends StatelessWidget {
  const CircularProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(primary()),
      ),
    );
  }
}
