import 'package:bloc/bloc.dart';
import 'package:test_task_bloc/data/models/contact_model.dart';
import 'package:test_task_bloc/data/repositories/contact_dao.dart';
import 'package:test_task_bloc/presentations/bloc/contact_bloc/contact_event.dart';
import 'package:test_task_bloc/presentations/bloc/contact_bloc/contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactLoadingState()) {
    on<LoadContactEvent>((event, emit) async {
      try {
        Contact? contact =
            await ContactDao.instance.getContactById(event.contactId);
        if (contact != null) {
          emit(ContactLoadedState(contact: contact));
        } else {
          emit(ContactErrorState('Contact not found'));
        }
      } catch (e) {
        emit(ContactErrorState('Error loading contact: $e'));
      }
    });
  }
}
