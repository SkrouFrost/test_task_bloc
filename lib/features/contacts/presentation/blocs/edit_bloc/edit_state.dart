import 'package:test_task_bloc/features/contacts/data/models/contact_model.dart';

abstract class EditContactState {}

class EditContactLoadingState extends EditContactState {}

class EditContactLoadedState extends EditContactState {
  final Contact contact;

  EditContactLoadedState(this.contact);
}

class EditContactErrorState extends EditContactState {
  final String errorMessage;

  EditContactErrorState(this.errorMessage);
}

class ContactSavedState extends EditContactState {}

class ContactDeletedState extends EditContactState {}
