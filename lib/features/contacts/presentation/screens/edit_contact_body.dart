import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task_bloc/core/styles/color_constants.dart';
import 'package:test_task_bloc/features/contacts/data/models/contact_model.dart';
import 'package:test_task_bloc/features/contacts/data/repositories/contact_dao.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/edit_bloc/edit_bloc.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/edit_bloc/edit_event.dart';
import 'package:test_task_bloc/features/contacts/presentation/widgets/confirmation_dialog.dart';
import 'package:test_task_bloc/features/contacts/presentation/widgets/info_row.dart';

class EditContactBody extends StatefulWidget {
  final String id;

  const EditContactBody({Key? key, required this.id}) : super(key: key);

  @override
  _EditContactBodyState createState() => _EditContactBodyState();
}

class _EditContactBodyState extends State<EditContactBody> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _streetAddress1Controller;
  late TextEditingController _streetAddress2Controller;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _zipCodeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
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
            const SizedBox(height: 10),
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
              onPressed: _saveChanges,
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: () => _showDeleteConfirmationDialog(context),
              style: ElevatedButton.styleFrom(backgroundColor: warningColor),
              child: const Text('Delete contact'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _streetAddress1Controller = TextEditingController();
    _streetAddress2Controller = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _zipCodeController = TextEditingController();
    _loadData();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _streetAddress1Controller.dispose();
    _streetAddress2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    Contact? contact = await ContactDao.instance.getContactById(widget.id);
    if (contact != null) {
      _firstNameController.text = contact.firstName;
      _lastNameController.text = contact.lastName;
      _phoneNumberController.text = contact.phoneNumber;
      _streetAddress1Controller.text = contact.streetAddress1;
      _streetAddress2Controller.text = contact.streetAddress2;
      _cityController.text = contact.city;
      _stateController.text = contact.state;
      _zipCodeController.text = contact.zipCode;
    }
    context.read<EditContactBloc>().add(LoadContactEvent(widget.id));
  }

  Future<void> _deleteContact() async {
    context.read<EditContactBloc>().add(DeleteContactEvent(widget.id));
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          onConfirm: _deleteContact,
        );
      },
    );
  }

  Future<void> _saveChanges() async {
    context.read<EditContactBloc>().add(SaveChangesEvent(
          contactId: widget.id,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          phoneNumber: _phoneNumberController.text,
          streetAddress1: _streetAddress1Controller.text,
          streetAddress2: _streetAddress2Controller.text,
          city: _cityController.text,
          state: _stateController.text,
          zipCode: _zipCodeController.text,
        ));
    context.pop();
    dispose();
  }
}
