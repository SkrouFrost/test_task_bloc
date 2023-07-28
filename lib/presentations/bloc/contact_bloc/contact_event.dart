abstract class ContactEvent {}

class LoadContactEvent extends ContactEvent {
  final String contactId;
  LoadContactEvent(this.contactId);
}