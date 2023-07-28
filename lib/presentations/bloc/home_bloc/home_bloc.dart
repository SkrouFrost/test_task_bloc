import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_bloc/data/models/contact_model.dart';
import 'package:test_task_bloc/data/repositories/contact_dao.dart';
import 'package:test_task_bloc/objectbox.g.dart';
import 'package:test_task_bloc/presentations/bloc/home_bloc/home_event.dart';
import 'package:test_task_bloc/presentations/bloc/home_bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Box<Contact> contactBox;

  HomeBloc(this.contactBox) : super(ContactsLoadingState()) {
    on<LoadContactsEvent>((event, emit) async {
      try {
        List<Contact> contacts = contactBox.getAll();
        emit(ContactsLoadedState(contacts));
      } catch (e) {
        emit(ContactsErrorState('Error database connections: $e'));
      }
    });
    on<InitializeContactsEvent>((event, emit) async {
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
    });
  }
}
