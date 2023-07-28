import 'package:equatable/equatable.dart';
import 'package:test_task_bloc/features/contacts/data/models/contact_model.dart';

abstract class AddContactEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SaveContactEvent extends AddContactEvent {
  final Contact newContact;

  SaveContactEvent(this.newContact);

  @override
  List<Object?> get props => [newContact];
}

class CalculateNewIdEvent extends AddContactEvent {}
