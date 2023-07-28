import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:test_task_bloc/data/models/contact_model.dart';

import 'package:test_task_bloc/presentations/bloc/add_bloc/add_event.dart';
import 'package:test_task_bloc/presentations/bloc/add_bloc/add_state.dart';
import 'package:test_task_bloc/data/repositories/contact_dao.dart';

class AddContactBloc extends Bloc<AddContactEvent, AddContactState> {
  AddContactBloc() : super(AddContactInitialState()) {
    _onSaveContactEvent();
    // on<SaveContactEvent>((event, emit) async {
    //   try {
    //     await ContactDao.instance.updateContact(event.newContact);
    //     emit(AddContactSuccessState());
    //   } catch (e) {
    //     emit(AddContactErrorState('Error saving contact: $e'));
    //   }
    // });
    on<CalculateNewIdEvent>((event, emit) async {
      try {
        final dao = ContactDao.instance;
        List<Contact> contacts = await dao.getContacts();
        int newId = contacts.isEmpty ? 0 : contacts.last.id + 1;
        emit(NewIdCalculatedState(newId));
      } catch (e) {
        emit(AddContactErrorState('Error calculating new ID: $e'));
      }
    });
  }

  void _onSaveContactEvent() {
    on<SaveContactEvent>((event, emit) async {
      try {
        await ContactDao.instance.updateContact(event.newContact);
        emit(AddContactSuccessState());
      } catch (e) {
        emit(AddContactErrorState('Error saving contact: $e'));
      }
    });
  }

  Stream<int> calculateNewId() async* {
    final dao = ContactDao.instance;
    List<Contact> contacts = await dao.getContacts();
    int newId = contacts.isEmpty ? 0 : contacts.last.id + 1;
    yield newId;
  }
}
