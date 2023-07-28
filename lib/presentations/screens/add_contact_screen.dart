import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task_bloc/data/models/contact_model.dart';
import 'package:test_task_bloc/presentations/bloc/add_bloc/add_bloc.dart';
import 'package:test_task_bloc/presentations/bloc/add_bloc/add_event.dart';
import 'package:test_task_bloc/presentations/widgets/info_row.dart';
import 'package:test_task_bloc/styles/color_constants.dart';

class AddContactScreen extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _streetAddress1Controller =
      TextEditingController();
  final TextEditingController _streetAddress2Controller =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  Future<void> addContact(BuildContext context) async {
    final newId = await context.read<AddContactBloc>().calculateNewId().first;

    Contact newContact = Contact(
      contactID: '$newId',
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      phoneNumber: _phoneNumberController.text,
      streetAddress1: _streetAddress1Controller.text,
      streetAddress2: _streetAddress2Controller.text,
      city: _cityController.text,
      state: _stateController.text,
      zipCode: _zipCodeController.text,
    );
    context.read<AddContactBloc>().add(SaveContactEvent(newContact));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightbackgroundColor,
        title: const Text('Add New Contact'),
        flexibleSpace: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            height: 4,
            color: backgroundColor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoRow(
                label: 'First name',
                valueController: _firstNameController,
              ),
              const SizedBox(height: 10),
              InfoRow(
                label: 'Last name',
                valueController: _lastNameController,
              ),
              const SizedBox(height: 10),
              InfoRow(
                label: 'Phone number',
                valueController: _phoneNumberController,
              ),
              const SizedBox(height: 10),
              InfoRow(
                label: 'Street address 1',
                valueController: _streetAddress1Controller,
              ),
              const SizedBox(height: 10),
              InfoRow(
                label: 'Street address 2',
                valueController: _streetAddress2Controller,
              ),
              const SizedBox(height: 10),
              InfoRow(
                label: 'City',
                valueController: _cityController,
              ),
              InfoRow(
                label: 'State',
                valueController: _stateController,
              ),
              const SizedBox(height: 10),
              InfoRow(
                label: 'Zip Code',
                valueController: _zipCodeController,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: lightbackgroundColor),
                onPressed: () => addContact(context),
                child: const Text('Save Contact'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
