abstract class EditContactEvent {}

class LoadContactEvent extends EditContactEvent {
  final String contactId;

  LoadContactEvent(this.contactId);
}

class SaveChangesEvent extends EditContactEvent {
  final String contactId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String streetAddress1;
  final String streetAddress2;
  final String city;
  final String state;
  final String zipCode;

  SaveChangesEvent({
    required this.contactId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.streetAddress1,
    required this.streetAddress2,
    required this.city,
    required this.state,
    required this.zipCode,
  });
}

class DeleteContactEvent extends EditContactEvent {
  final String contactId;

  DeleteContactEvent(this.contactId);
}
