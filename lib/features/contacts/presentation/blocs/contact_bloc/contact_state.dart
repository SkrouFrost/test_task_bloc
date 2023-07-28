import 'package:test_task_bloc/features/contacts/data/models/contact_model.dart';

abstract class ContactState {}

class ContactLoadingState extends ContactState {}

class ContactLoadedState extends ContactState {
  final Contact? contact;

  ContactLoadedState({required this.contact});
}

class ContactErrorState extends ContactState {
  final String errorMessage;

  ContactErrorState(this.errorMessage);
}
