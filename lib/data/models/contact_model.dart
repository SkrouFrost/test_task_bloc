import 'package:objectbox/objectbox.dart';

@Entity()
class Contact {
  int id;
  String contactID;
  String firstName;
  String lastName;
  String phoneNumber;
  String streetAddress1;
  String streetAddress2;
  String city;
  String state;
  String zipCode;

  Contact({
    this.id = 0,
    required this.contactID,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.streetAddress1,
    required this.streetAddress2,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  @Id()
  int get objectId => id;

  Contact copyWith({
    int? id,
    String? contactID,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? streetAddress1,
    String? streetAddress2,
    String? city,
    String? state,
    String? zipCode,
  }) {
    return Contact(
      id: id ?? this.id,
      contactID: contactID ?? this.contactID,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      streetAddress1: streetAddress1 ?? this.streetAddress1,
      streetAddress2: streetAddress2 ?? this.streetAddress2,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
    );
  }
}
