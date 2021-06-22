import 'package:teste/model/recap_note.dart';

abstract class ManageEvent {}

class DeleteEvent extends ManageEvent {
  int noteId;
  DeleteEvent({this.noteId});
}

class UpdateRequest extends ManageEvent {
  int noteId;
  RecapNote previousNote;

  UpdateRequest({this.noteId, this.previousNote});
}

class UpdateCancel extends ManageEvent {}

class SubmitEvent extends ManageEvent {
  RecapNote note;
  SubmitEvent({this.note});
}

class SubmitReviewEvent extends ManageEvent {
  RecapNote note;
  SubmitReviewEvent({this.note});
}
