import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_bloc/features/contacts/data/models/contact_model.dart';
import 'package:test_task_bloc/features/contacts/data/repositories/contact_dao.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/edit_bloc/edit_event.dart';
import 'package:test_task_bloc/features/contacts/presentation/blocs/edit_bloc/edit_state.dart';

class EditContactBloc extends Bloc<EditContactEvent, EditContactState> {
  final dao = ContactDao.instance;

  EditContactBloc() : super(EditContactLoadingState()) {
    on<LoadContactEvent>(_onLoadContact);
    on<SaveChangesEvent>(_onSaveChanges);
    on<DeleteContactEvent>(_onDeleteContact);
  }

  Future<void> _onLoadContact(
      LoadContactEvent event, Emitter<EditContactState> emit) async {
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
  }

  Future<void> _onSaveChanges(
      SaveChangesEvent event, Emitter<EditContactState> emit) async {
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
  }

  Future<void> _onDeleteContact(
      DeleteContactEvent event, Emitter<EditContactState> emit) async {
    try {
      Contact? contact = await dao.getContactById(event.contactId);
      if (contact != null) {
        await dao.deleteContact(contact.id);
        emit(ContactDeletedState());
      }
    } catch (e) {
      emit(EditContactErrorState('Error deleting contact: $e'));
    }
  }
}
