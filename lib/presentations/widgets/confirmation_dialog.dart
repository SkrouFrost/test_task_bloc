import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task_bloc/styles/color_constants.dart';

class ConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ConfirmationDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Deleting contact'),
      content: const Text('Are you sure?'),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            context.go('/');
            onConfirm();
          },
          style: TextButton.styleFrom(foregroundColor: warningColor),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
