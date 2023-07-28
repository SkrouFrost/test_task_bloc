import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_bloc/features/contacts/data/models/contact_model.dart';
import 'package:test_task_bloc/features/contacts/data/repositories/contact_dao.dart';
import 'package:test_task_bloc/core/objectBox/objectbox.g.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/home_bloc/home_event.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/home_bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Box<Contact> contactBox;

  HomeBloc(this.contactBox) : super(ContactsLoadingState()) {
    on<LoadContactsEvent>(_onLoadContacts);
    on<InitializeContactsEvent>(_onInitializeContacts);
  }


  Future<void> _onLoadContacts(
      LoadContactsEvent event, Emitter<HomeState> emit) async {
    try {
      List<Contact> contacts = contactBox.getAll();
      emit(ContactsLoadedState(contacts));
    } catch (e) {
      emit(ContactsErrorState('Error database connections: $e'));
    }
  }

  Future<void> _onInitializeContacts(
      InitializeContactsEvent event, Emitter<HomeState> emit) async {
    final String jsonString = await rootBundle.loadString('assets/list.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    final List<Contact> contacts = jsonList
        .map((json) => Contact(
              contactID: json['contactID'],
              firstName: json['firstName'],
              lastName: json['lastName'],
              phoneNumber: json['phoneNumber'],
              streetAddress1: json['streetAddress1'],
              streetAddress2: json['streetAddress2'],
              city: json['city'],
              state: json['state'],
              zipCode: json['zipCode'],
            ))
        .toList();

    int count = await ContactDao.instance.retrieveContactsCount();
    if (count == 0) {
      await ContactDao.instance.saveContacts(contacts);
      emit(ContactsLoadedState(contacts));
    } else {
      emit(ContactsLoadedState(await ContactDao.instance.getContacts()));
    }
  }
}
