import 'package:teste/model/recap_note.dart';

abstract class MonitorEvent {}

class AskNewList extends MonitorEvent {}

class UpdateList extends MonitorEvent {
  List<RecapNote> noteList;
  List<int> idList;
  UpdateList({this.noteList, this.idList});
}
