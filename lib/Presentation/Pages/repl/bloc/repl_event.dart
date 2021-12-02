part of 'signin_bloc.dart';

abstract class ReplEvent {}

class SaveCodeToLocalStorage extends ReplEvent {
  final String code;

  SaveCodeToLocalStorage({required this.code});

  @override
  String toString() => 'signIn {}';
}

class LoadFromLocalStorage extends ReplEvent {
  LoadFromLocalStorage();

  @override
  String toString() => 'FirstTimeLogin {}';
}

class SubmitCode extends ReplEvent {
  final String code;
  SubmitCode({required this.code});
  @override
  String toString() => 'signIn {}';
}
