part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class EmailChanged extends RegisterEvent {
  const EmailChanged({
    required this.email,
  });
  final String email;

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends RegisterEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object?> get props => [password];
}

class ConfirmationPasswordChanged extends RegisterEvent {
  const ConfirmationPasswordChanged({required this.confirmationPassword});

  final String confirmationPassword;

  @override
  List<Object?> get props => [confirmationPassword];
}

class ShowHidePasswordPressed extends RegisterEvent {}

class ShowHideConfirmationPasswordPressed extends RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {}
