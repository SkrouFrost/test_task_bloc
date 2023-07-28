import 'package:test_task_bloc/data/models/contact_model.dart';

abstract class HomeState {}

class ContactsLoadingState extends HomeState {}

class ContactsLoadedState extends HomeState {
  final List<Contact> contacts;

  ContactsLoadedState(this.contacts);
}

class ContactsErrorState extends HomeState {
  final String errorMessage;

  ContactsErrorState(this.errorMessage);
}
