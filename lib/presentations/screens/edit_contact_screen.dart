import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task_bloc/presentations/screens/edit_contact_body.dart';
import 'package:test_task_bloc/styles/color_constants.dart';

class ContactEditScreen extends StatelessWidget {
  final String id;

  const ContactEditScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Edit contact'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        flexibleSpace: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            height: 4,
            color: backgroundColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditContactBody(id: id),
            ],
          ),
        ),
      ),
    );
  }
}
