part of 'repl_bloc.dart';

abstract class ReplEvent {}

class SaveCodeToLocalStorage extends ReplEvent {
  final String code;

  SaveCodeToLocalStorage({required this.code});

  @override
  String toString() => 'SaveCodeToLocalStorage {}';
}

class LoadFromLocalStorage extends ReplEvent {
  LoadFromLocalStorage();

  @override
  String toString() => 'LoadFromLocalStorage {}';
}

class SubmitCode extends ReplEvent {
  final String code;
  SubmitCode({required this.code});
  @override
  String toString() => 'SubmitCode {}';
}
