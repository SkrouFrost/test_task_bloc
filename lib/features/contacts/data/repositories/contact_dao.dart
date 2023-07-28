import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:test_task_bloc/features/contacts/data/models/contact_model.dart';
import 'package:test_task_bloc/core/objectBox/objectbox.g.dart';

class ContactDao {
  late final Store _store;
  late final Box<Contact> _contactBox;

  Box<Contact> get box => _contactBox; // Add this getter method
  ContactDao._privateConstructor();

  static final ContactDao _instance = ContactDao._privateConstructor();

  static ContactDao get instance => _instance;

  Future<void> openBox() async {
    final Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    final String objectBoxDirectory = '${appDocumentsDirectory.path}/objectbox';

    _store = await openStore(directory: objectBoxDirectory);
    _contactBox = _store.box<Contact>();
  }

  Future<void> closeBox() async {
    _store.close();
  }

  Future<void> saveContacts(List<Contact> contacts) async {
    _contactBox.removeAll();

    for (var contact in contacts) {
      _contactBox.put(contact);
    }
  }

  Future<int> retrieveContactsCount() async {
    int count = _contactBox.count();
    return count;
  }

  Future<List<Contact>> getContacts() async {
    return _contactBox.getAll();
  }

  Future<Contact?> getContactById(String contactId) async {
    int? id = int.tryParse(contactId) ?? 0;
    print('$id');
    return _contactBox.get(id);
  }

  Future<void> updateContact(Contact contact) async {
    _contactBox.put(contact);
  }

  Future<void> deleteContact(int contactId) async {
    _contactBox.remove(contactId);
  }
}
