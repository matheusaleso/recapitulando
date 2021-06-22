import 'package:teste/model/recap_note.dart';

abstract class ManageState {}

class UpdateState extends ManageState {
  int noteId;
  RecapNote previousNote;
  UpdateState({this.noteId, this.previousNote});
}

class InsertState extends ManageState {}
