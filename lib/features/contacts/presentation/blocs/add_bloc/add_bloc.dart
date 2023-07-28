import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:test_task_bloc/features/contacts/data/models/contact_model.dart';
import 'package:test_task_bloc/features/contacts/data/repositories/contact_dao.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/add_bloc/add_event.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/add_bloc/add_state.dart';

class AddContactBloc extends Bloc<AddContactEvent, AddContactState> {
  final dao = ContactDao.instance;

  AddContactBloc() : super(AddContactInitialState()) {
    on<SaveContactEvent>(_onSaveContact);
    on<CalculateNewIdEvent>(_onCalculateNewId);
  }

  Stream<int> calculateNewId() async* {
    List<Contact> contacts = await dao.getContacts();
    int newId = contacts.isEmpty ? 0 : contacts.last.id + 1;
    yield newId;
  }

  Future<void> _onSaveContact(
      SaveContactEvent event, Emitter<AddContactState> emit) async {
    try {
      await dao.updateContact(event.newContact);
      emit(AddContactSuccessState());
    } catch (e) {
      emit(AddContactErrorState('Error saving contact: $e'));
    }
  }

  Future<void> _onCalculateNewId(
      CalculateNewIdEvent event, Emitter<AddContactState> emit) async {
    try {
      List<Contact> contacts = await dao.getContacts();
      int newId = contacts.isEmpty ? 0 : contacts.last.id + 1;
      emit(NewIdCalculatedState(newId));
    } catch (e) {
      emit(AddContactErrorState('Error calculating new ID: $e'));
    }
  }
}
