import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_bloc/data/models/contact_model.dart';
import 'package:test_task_bloc/data/repositories/contact_dao.dart';
import 'package:test_task_bloc/presentations/bloc/edit_bloc/edit_event.dart';
import 'package:test_task_bloc/presentations/bloc/edit_bloc/edit_state.dart';

class EditContactBloc extends Bloc<EditContactEvent, EditContactState> {
  EditContactBloc() : super(EditContactLoadingState()) {
    final dao = ContactDao.instance;
    on<LoadContactEvent>((event, emit) async {
      emit(EditContactLoadingState());
      try {
        Contact? contact = await dao.getContactById(event.contactId);
        if (contact != null) {
          emit(EditContactLoadedState(contact));
        } else {
          emit(EditContactErrorState('Contact not found'));
        }
      } catch (e) {
        emit(EditContactErrorState('Error loading contact: $e'));
      }
    });
    on<SaveChangesEvent>((event, emit) async {
      try {
        Contact? contact = await dao.getContactById(event.contactId);
        if (contact != null) {
          contact = contact.copyWith(
            firstName: event.firstName,
            lastName: event.lastName,
            phoneNumber: event.phoneNumber,
            streetAddress1: event.streetAddress1,
            streetAddress2: event.streetAddress2,
            city: event.city,
            state: event.state,
            zipCode: event.zipCode,
          );
          await dao.updateContact(contact);
          emit(ContactSavedState());
        } else {
          emit(EditContactErrorState('Contact not found'));
        }
      } catch (e) {
        emit(EditContactErrorState('Error saving contact: $e'));
      }
    });
    on<DeleteContactEvent>((event, emit) async {
      try {
        Contact? contact = await dao.getContactById(event.contactId);
        if (contact != null) {
          await dao.deleteContact(contact.id);
          emit(ContactDeletedState());
        }
      } catch (e) {
        emit(EditContactErrorState('Error deleting contact: $e'));
      }
    });
  }
}
