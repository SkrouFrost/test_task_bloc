import 'package:equatable/equatable.dart';

abstract class AddContactState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddContactInitialState extends AddContactState {}

class AddContactSuccessState extends AddContactState {}

class AddContactErrorState extends AddContactState {
  final String errorMessage;

  AddContactErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class NewIdCalculatedState extends AddContactState {
  final int newId;

  NewIdCalculatedState(this.newId);

  @override
  List<Object?> get props => [newId];
}
