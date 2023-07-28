import 'package:flutter/material.dart';
import 'package:test_task_bloc/styles/color_constants.dart';
import 'package:test_task_bloc/styles/fonts.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final TextEditingController valueController;

  const InfoRow(
      {super.key, required this.label, required this.valueController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: contactLabelStyle,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 20,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
          decoration: BoxDecoration(
            color: lightbackgroundColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextField(
            controller: valueController,
            style: contactValueStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter $label',
            ),
          ),
        ),
      ],
    );
  }
}
