import 'package:flutter/material.dart';
import 'package:test_task_bloc/styles/color_constants.dart';

class CircleWidget extends StatelessWidget {
  final double radius;

  const CircleWidget({super.key, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: circleColor,
      ),
    );
  }
}
