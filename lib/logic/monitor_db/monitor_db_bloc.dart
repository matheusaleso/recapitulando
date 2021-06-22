import 'dart:async';
import 'package:teste/data/local/local_databse.dart';
import 'package:teste/data/web_server/remote_databse.dart';
import 'package:teste/data/web_server/FirebaseRemoteServer.dart';
import 'package:teste/logic/monitor_db/monitor_db_event.dart';
import 'package:teste/logic/monitor_db/monitor_db_state.dart';
import 'package:teste/model/recap_note.dart';
import 'package:bloc/bloc.dart';

class MonitorBloc extends Bloc<MonitorEvent, MonitorState> {
  StreamSubscription _localSubscription;
  StreamSubscription _remoteSubscription;

  List<RecapNote> localNoteList;
  List<RecapNote> remoteNoteList;
  List<int> localIdList;
  List<int> remoteIdList;

  MonitorBloc() : super(MonitorState(noteList: [], idList: [])) {
    add(AskNewList());
    _localSubscription = DatabaseLocalServer.helper.stream.listen((response) {
      try {
        localNoteList = response[0];
        localIdList = response[1];
        add(UpdateList(
            noteList: List.from(localNoteList)..addAll(remoteNoteList),
            idList: List.from(localIdList)..addAll(remoteIdList)));
      } catch (e) {}
    });
    _remoteSubscription = DatabaseRemoteServer.helper.stream.listen((response) {
      try {
        remoteNoteList = response[0];
        remoteIdList = response[1];
        add(UpdateList(
            noteList: List.from(localNoteList)..addAll(remoteNoteList),
            idList: List.from(localIdList)..addAll(remoteIdList)));
      } catch (e) {}
    });
  }

  @override
  Stream<MonitorState> mapEventToState(MonitorEvent event) async* {
    if (event is AskNewList) {
      var localResponse = await DatabaseLocalServer.helper.getNoteList();
      var remoteResponse = await DatabaseRemoteServer.helper.getNoteList();
      localNoteList = localResponse[0];
      localIdList = localResponse[1];
      remoteNoteList = remoteResponse[0];
      remoteIdList = remoteResponse[1];
      yield MonitorState(
          noteList: List.from(localNoteList)..addAll(remoteNoteList),
          idList: List.from(localIdList)..addAll(remoteIdList));
    } else if (event is UpdateList) {
      yield MonitorState(idList: event.idList, noteList: event.noteList);
    }
  }

  close() {
    _localSubscription.cancel();
    _remoteSubscription.cancel();
    return super.close();
  }
}

class MonitorBlocSeries extends Bloc<MonitorEvent, MonitorState> {
  StreamSubscription _remoteSubscription;

  List<RecapNote> localNoteList;
  List<RecapNote> remoteNoteList;
  List<int> localIdList;
  List<int> remoteIdList;

  MonitorBlocSeries() : super(MonitorState(noteList: [], idList: [])) {
    add(AskNewList());

    _remoteSubscription = DatabaseRemoteServer.helper.stream.listen((response) {
      try {
        remoteNoteList = response[0];
        remoteIdList = response[1];
        add(UpdateList(
            noteList: List.from(localNoteList)..addAll(remoteNoteList),
            idList: List.from(localIdList)..addAll(remoteIdList)));
      } catch (e) {}
    });
  }

  @override
  Stream<MonitorState> mapEventToState(MonitorEvent event) async* {
    if (event is AskNewList) {
      var localResponse = await DatabaseLocalServer.helper.getNoteList();
      var remoteResponse =
          await DatabaseRemoteServer.helper.getNoteListSeries();
      localNoteList = localResponse[0];
      localIdList = localResponse[1];
      remoteNoteList = remoteResponse[0];
      remoteIdList = remoteResponse[1];
      yield MonitorState(
          noteList: List.from(localNoteList)..addAll(remoteNoteList),
          idList: List.from(localIdList)..addAll(remoteIdList));
    } else if (event is UpdateList) {
      yield MonitorState(idList: event.idList, noteList: event.noteList);
    }
  }

  close() {
    _remoteSubscription.cancel();
    return super.close();
  }
}

class MonitorBlocTemporadas extends Bloc<MonitorEvent, MonitorState> {
  StreamSubscription _remoteSubscription;

  List<RecapNote> localNoteList;
  List<RecapNote> remoteNoteList;
  List<int> localIdList;
  List<int> remoteIdList;

  MonitorBlocTemporadas() : super(MonitorState(noteList: [], idList: [])) {
    add(AskNewList());

    _remoteSubscription = DatabaseRemoteServer.helper.stream.listen((response) {
      try {
        remoteNoteList = response[0];
        remoteIdList = response[1];
        add(UpdateList(
            noteList: List.from(localNoteList)..addAll(remoteNoteList),
            idList: List.from(localIdList)..addAll(remoteIdList)));
      } catch (e) {}
    });
  }

  @override
  Stream<MonitorState> mapEventToState(MonitorEvent event) async* {
    if (event is AskNewList) {
      var localResponse = await DatabaseLocalServer.helper.getNoteList();
      var remoteResponse =
          await DatabaseRemoteServer.helper.getNoteListTemporadas();
      localNoteList = localResponse[0];
      localIdList = localResponse[1];
      remoteNoteList = remoteResponse[0];
      remoteIdList = remoteResponse[1];
      yield MonitorState(
          noteList: List.from(localNoteList)..addAll(remoteNoteList),
          idList: List.from(localIdList)..addAll(remoteIdList));
    } else if (event is UpdateList) {
      yield MonitorState(idList: event.idList, noteList: event.noteList);
    }
  }

  close() {
    _remoteSubscription.cancel();
    return super.close();
  }
}

class MonitorBlocReviews extends Bloc<MonitorEvent, MonitorState> {
  StreamSubscription _remoteSubscription;

  List<RecapNote> localNoteList;
  List<RecapNote> remoteNoteList;
  List<int> localIdList;
  List<int> remoteIdList;

  MonitorBlocReviews() : super(MonitorState(noteList: [], idList: [])) {
    add(AskNewList());

    _remoteSubscription = DatabaseRemoteServer.helper.stream.listen((response) {
      try {
        remoteNoteList = response[0];
        remoteIdList = response[1];
        add(UpdateList(
            noteList: List.from(localNoteList)..addAll(remoteNoteList),
            idList: List.from(localIdList)..addAll(remoteIdList)));
      } catch (e) {}
    });
  }

  @override
  Stream<MonitorState> mapEventToState(MonitorEvent event) async* {
    if (event is AskNewList) {
      var localResponse = await DatabaseLocalServer.helper.getNoteList();
      var remoteResponse =
          await DatabaseRemoteServer.helper.getNoteListReviews();
      localNoteList = localResponse[0];
      localIdList = localResponse[1];
      remoteNoteList = remoteResponse[0];
      remoteIdList = remoteResponse[1];
      yield MonitorState(
          noteList: List.from(localNoteList)..addAll(remoteNoteList),
          idList: List.from(localIdList)..addAll(remoteIdList));
    } else if (event is UpdateList) {
      yield MonitorState(idList: event.idList, noteList: event.noteList);
    }
  }

  close() {
    _remoteSubscription.cancel();
    return super.close();
  }
}

/*Firebase*/
class MonitorBlocSeriesF extends Bloc<MonitorEvent, MonitorState> {
  StreamSubscription _firebaseSubscription;

  List<RecapNote> localNoteList;
  List<RecapNote> remoteNoteList;
  List<RecapNote> firebaseNoteList;
  List<int> localIdList;
  List<int> remoteIdList;
  List<int> firebaseIdList;

  MonitorBlocSeriesF() : super(MonitorState(noteList: [], idList: [])) {
    add(AskNewList());
    _firebaseSubscription =
        FirebaseRemoteServer.helper.stream.listen((response) {
      try {
        firebaseNoteList = response[0];
        firebaseIdList = response[1];
        add(UpdateList(
          noteList: List.from(localNoteList)
            ..addAll(remoteNoteList)
            ..addAll(firebaseNoteList),
          idList: List.from(localIdList)
            ..addAll(remoteIdList)
            ..addAll(firebaseIdList),
        ));
      } catch (e) {}
    });
  }

  @override
  Stream<MonitorState> mapEventToState(MonitorEvent event) async* {
    if (event is AskNewList) {
      var localResponse = await DatabaseLocalServer.helper.getNoteList();
      var remoteResponse =
          await DatabaseRemoteServer.helper.getNoteListSeries();
      var firebaseResponse =
          await FirebaseRemoteServer.helper.getNoteListSeries();
      localNoteList = localResponse[0];
      localIdList = localResponse[1];
      remoteNoteList = remoteResponse[0];
      remoteIdList = remoteResponse[1];
      firebaseNoteList = firebaseResponse[0];
      firebaseIdList = firebaseResponse[1];
      yield MonitorState(
          noteList: List.from(localNoteList)
            ..addAll(remoteNoteList)
            ..addAll(firebaseNoteList),
          idList: List.from(localIdList)
            ..addAll(remoteIdList)
            ..addAll(firebaseIdList));
    } else if (event is UpdateList) {
      yield MonitorState(idList: event.idList, noteList: event.noteList);
    }
  }

  close() {
    //_remoteSubscription.cancel();
    _firebaseSubscription.cancel();
    return super.close();
  }
}

class MonitorBlocSeasonsF extends Bloc<MonitorEvent, MonitorState> {
  StreamSubscription _firebaseSubscription;

  List<RecapNote> localNoteList;
  List<RecapNote> remoteNoteList;
  List<RecapNote> firebaseNoteList;
  List<int> localIdList;
  List<int> remoteIdList;
  List<int> firebaseIdList;

  MonitorBlocSeasonsF() : super(MonitorState(noteList: [], idList: [])) {
    add(AskNewList());
    _firebaseSubscription =
        FirebaseRemoteServer.helper.stream.listen((response) {
      try {
        firebaseNoteList = response[0];
        firebaseIdList = response[1];
        add(UpdateList(
          noteList: List.from(localNoteList)
            ..addAll(remoteNoteList)
            ..addAll(firebaseNoteList),
          idList: List.from(localIdList)
            ..addAll(remoteIdList)
            ..addAll(firebaseIdList),
        ));
      } catch (e) {}
    });
  }

  @override
  Stream<MonitorState> mapEventToState(MonitorEvent event) async* {
    if (event is AskNewList) {
      var localResponse = await DatabaseLocalServer.helper.getNoteList();
      var remoteResponse =
          await DatabaseRemoteServer.helper.getNoteListSeries();
      var firebaseResponse =
          await FirebaseRemoteServer.helper.getNoteListSeasons();
      localNoteList = localResponse[0];
      localIdList = localResponse[1];
      remoteNoteList = remoteResponse[0];
      remoteIdList = remoteResponse[1];
      firebaseNoteList = firebaseResponse[0];
      firebaseIdList = firebaseResponse[1];
      yield MonitorState(
          noteList: List.from(localNoteList)
            ..addAll(remoteNoteList)
            ..addAll(firebaseNoteList),
          idList: List.from(localIdList)
            ..addAll(remoteIdList)
            ..addAll(firebaseIdList));
    } else if (event is UpdateList) {
      yield MonitorState(idList: event.idList, noteList: event.noteList);
    }
  }

  close() {
    //_remoteSubscription.cancel();
    _firebaseSubscription.cancel();
    return super.close();
  }
}

class MonitorBlocReviewsF extends Bloc<MonitorEvent, MonitorState> {
  StreamSubscription _firebaseSubscription;

  List<RecapNote> localNoteList;
  List<RecapNote> remoteNoteList;
  List<RecapNote> firebaseNoteList;
  List<int> localIdList;
  List<int> remoteIdList;
  List<int> firebaseIdList;

  MonitorBlocReviewsF() : super(MonitorState(noteList: [], idList: [])) {
    add(AskNewList());
    _firebaseSubscription =
        FirebaseRemoteServer.helper.stream.listen((response) {
      try {
        firebaseNoteList = response[0];
        firebaseIdList = response[1];
        add(UpdateList(
          noteList: List.from(localNoteList)
            ..addAll(remoteNoteList)
            ..addAll(firebaseNoteList),
          idList: List.from(localIdList)
            ..addAll(remoteIdList)
            ..addAll(firebaseIdList),
        ));
      } catch (e) {}
    });
  }

  @override
  Stream<MonitorState> mapEventToState(MonitorEvent event) async* {
    if (event is AskNewList) {
      var localResponse = await DatabaseLocalServer.helper.getNoteList();
      var remoteResponse =
          await DatabaseRemoteServer.helper.getNoteListSeries();
      var firebaseResponse =
          await FirebaseRemoteServer.helper.getNoteListReviews();
      localNoteList = localResponse[0];
      localIdList = localResponse[1];
      remoteNoteList = remoteResponse[0];
      remoteIdList = remoteResponse[1];
      firebaseNoteList = firebaseResponse[0];
      firebaseIdList = firebaseResponse[1];
      yield MonitorState(
          noteList: List.from(localNoteList)
            ..addAll(remoteNoteList)
            ..addAll(firebaseNoteList),
          idList: List.from(localIdList)
            ..addAll(remoteIdList)
            ..addAll(firebaseIdList));
    } else if (event is UpdateList) {
      yield MonitorState(idList: event.idList, noteList: event.noteList);
    }
  }

  close() {
    _firebaseSubscription.cancel();
    return super.close();
  }
}
