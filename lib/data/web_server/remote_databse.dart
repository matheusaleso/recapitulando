import 'dart:async';
import 'dart:convert';
//import 'dart:io';
import 'package:dio/dio.dart';
import 'package:teste/model/recap_note.dart';
import 'package:socket_io_client/socket_io_client.dart';

List<RecapNote> listreviewsrates = List<RecapNote>.empty(growable: true);

class DatabaseRemoteServer {
  /* 
    Criando singleton
  */
  static DatabaseRemoteServer helper = DatabaseRemoteServer._createInstance();
  DatabaseRemoteServer._createInstance();

  /* String databaseURL = 'http://192.168.1.168:3000/usuarios';
  String databaseURLSeries = 'http://192.168.1.168:3000/series';
  String databaseURLTemporadas = 'http://192.168.1.168:3000/temporadas';
  String databaseURLReviews = 'http://192.168.1.168:3000/reviews';*/
/*
  String databaseURL = "https://si700.herokuapp.com/notes";
  String databaseURLSeries = "https://si700.herokuapp.com/notes";
  String databaseURLTemporadas = "https://si700.herokuapp.com/notes";
  String databaseURLReviews = "https://si700.herokuapp.com/notes";
*/
  ///*
  String databaseURL = "https://recapitulando-teste.herokuapp.com/users";
  String databaseURLSeries = "https://recapitulando-teste.herokuapp.com/users";
  String databaseURLTemporadas =
      "https://recapitulando-teste.herokuapp.com/users";
  String databaseURLReviews = "https://recapitulando-teste.herokuapp.com/users";
  //*/

  Dio _dio = Dio();

  /*static const baseUrl =
      'https://recapitulando-firebase-default-rtdb.firebaseio.com/';*/
  Future<int> insertReviewF(RecapNote note) async {
    await _dio.post(this.databaseURLReviews,
        options: Options(headers: {"Accept": "application/json"}),
        data: jsonEncode({
          "username": note.username,
          "idSerie": note.idSerie,
          "temporada": note.season,
          "episodios": note.episodes,
          "rate": note.rate,
          "comment": note.comment,
        }));
    return 1;
  }
  /*Future<List<dynamic>> getNoteList() async {
    Response response = await _dio.request(this.databaseURL,
        options: Options(method: "GET", headers: {
          "Accept": "application/json",
        }));

    List<RecapNote> noteList = [];
    List<int> idList = [];

    response.data.forEach((element) {
      element["dataLocation"] = 2;
      RecapNote note = RecapNote.fromMap(element);
      noteList.add(note);
      idList.add(element["id"]);
    });


    return [noteList, idList];
  }*/

  Future<List<dynamic>> getNoteList() async {
    Response response = await _dio.request(this.databaseURL,
        options: Options(method: "GET", headers: {
          "Accept": "application/json",
        }));
    List<RecapNote> noteList = [];
    List<int> idList = [];

    for (int i = 0; i < response.data.length; i++) {
      RecapNote note = RecapNote.fromMap(response.data[i]);
      note.dataLocation = 2;
      noteList.add(note);
      if (response.data[i]["id"].runtimeType == String) {
        response.data[i]["id"] = int.parse(response.data[i]["id"]);
      }
      idList.add(response.data[i]["id"]);
    }

    return [noteList, idList];
  }

  Future<List<dynamic>> getNoteListSeries() async {
    Response response = await _dio.request(this.databaseURLSeries,
        options: Options(method: "GET", headers: {
          "Accept": "application/json",
        }));
    List<RecapNote> noteList = [];
    List<int> idList = [];

    for (int i = 0; i < response.data.length; i++) {
      RecapNote note = RecapNote.fromMap(response.data[i]);
      note.dataLocation = 2;
      noteList.add(note);
      if (response.data[i]["id"].runtimeType == String) {
        response.data[i]["id"] = int.parse(response.data[i]["id"]);
      }
      idList.add(response.data[i]["id"]);
    }
    return [noteList, idList];
  }

  Future<List<dynamic>> getNoteListTemporadas() async {
    Response response = await _dio.request(this.databaseURLTemporadas,
        options: Options(method: "GET", headers: {
          "Accept": "application/json",
        }));
    List<RecapNote> noteList = [];
    List<int> idList = [];

    for (int i = 0; i < response.data.length; i++) {
      RecapNote note = RecapNote.fromMap(response.data[i]);
      note.dataLocation = 2;
      noteList.add(note);
      if (response.data[i]["id"].runtimeType == String) {
        response.data[i]["id"] = int.parse(response.data[i]["id"]);
      }
      idList.add(response.data[i]["id"]);
    }

    return [noteList, idList];
  }

  Future<List<dynamic>> getNoteListReviews() async {
    Response response = await _dio.request(this.databaseURLReviews,
        options: Options(method: "GET", headers: {
          "Accept": "application/json",
        }));
    List<RecapNote> noteList = [];
    List<int> idList = [];

    for (int i = 0; i < response.data.length; i++) {
      RecapNote note = RecapNote.fromMap(response.data[i]);
      note.dataLocation = 2;
      noteList.add(note);
      if (response.data[i]["id"].runtimeType == String) {
        response.data[i]["id"] = int.parse(response.data[i]["id"]);
      }
      idList.add(response.data[i]["id"]);
    }

    return [noteList, idList];
  }

  Future<int> insertNote(RecapNote note) async {
    await _dio.post(this.databaseURL,
        options: Options(headers: {"Accept": "application/json"}),
        data: jsonEncode({
          "name": note.name,
          "username": note.username,
          "email": note.email,
          "favoriteSerie": note.favoriteSerie,
          "password": note.password,
          "action": note.action,
          "adventure": note.adventure,
          "comedy": note.comedy,
          "drama": note.drama,
          "fantasy": note.fantasy,
          "horror": note.horror,
          "musical": note.musical
        }));
    return 1;
  }

  Future<int> insertReview(RecapNote note) async {
    await _dio.post(this.databaseURLReviews,
        options: Options(headers: {"Accept": "application/json"}),
        data: jsonEncode({
          "username": note.username,
          "idSerie": note.idSerie,
          "temporada": note.season,
          "episodios": note.episodes,
          "rate": note.rate,
          "comment": note.comment,
        }));
    return 1;
  }

  Future<int> updateNote(int noteId, RecapNote note) async {
    await _dio.put(this.databaseURL + "/$noteId",
        options: Options(headers: {"Accept": "application/json"}),
        data: jsonEncode({
          "name": note.name,
          "idSerie": note.email,
          "temporada": note.favoriteSerie,
          "episodios": note.password,
          "rate": note.action,
          "comment": note.adventure,
          "comedy": note.comedy,
          "drama": note.drama,
          "fantasy": note.fantasy,
          "horror": note.horror,
          "musical": note.musical
        }));

    return 1;
  }

  Future<int> deleteNote(int noteId) async {
    await _dio.delete(this.databaseURL + "/$noteId",
        options: Options(method: "GET", headers: {
          "Accept": "application/json",
        }));
    return 1;
  }

  /*
    STREAM
  */

  notify() async {
    if (_controller != null) {
      var response = await getNoteList();
      _controller.sink.add(response);
    }
  }

  Stream get stream {
    if (_controller == null) {
      _controller = StreamController();
      Socket socket = io(
          'http://192.168.1.168:3000',
          OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
              .build());
      socket.on('invalidate', (_) => notify());
    }
    return _controller.stream.asBroadcastStream();
  }

  dispose() {
    if (!_controller.hasListener) {
      _controller.close();
      _controller = null;
    }
  }

  //static StreamController _controller;
  //static StreamController<dynamic> _controller = StreamController<bool>();
  static StreamController<dynamic> _controller =
      StreamController<dynamic>.broadcast();
}

void main() async {
  DatabaseRemoteServer noteService = DatabaseRemoteServer.helper;

  var response = await noteService.getNoteListReviews();
  RecapNote note = response[0][1];
  note.username = "laranjinha";
  note.idSerie = 2;
  note.season = 1;
  note.episodes = 2;
  note.rate = 3;
  note.comment = "Bacana";

  noteService.insertReview(note);

  //print(note.rate);
  //listreviews = response;
  //print(response.runtimeType);

  /*RecapNote note1 = RecapNote();
  note1.name = "Maria Maria";
  note1.email = "teste@gmail.com";
  note1.favoriteSerie = "Xena";
  note1.password = "aaaa";
  note1.action = 1;
  note1.adventure = 0;
  note1.comedy = 1;
  note1.drama = 1;
  note1.fantasy = 0;
  note1.horror = 0;
  note1.musical = 1;

  print(note1.name);
  noteService.deleteNote(2);*/

  //noteService.updateNote(0, note1);
}
