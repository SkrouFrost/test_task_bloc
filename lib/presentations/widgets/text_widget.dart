import 'package:flutter/material.dart';
import 'package:test_task_bloc/styles/fonts.dart';

class TextWidget extends StatelessWidget {
  final String text;

  const TextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: contactValueStyle);
  }
}
