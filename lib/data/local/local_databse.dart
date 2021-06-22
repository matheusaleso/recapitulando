import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teste/model/recap_note.dart';

class DatabaseLocalServer {
/* 
    Criando singleton
  */
  static DatabaseLocalServer helper = DatabaseLocalServer._createInstance();
  DatabaseLocalServer._createInstance();

  static Database _database;

  String recapNoteTable = "note_table";
  String recapNotecolId = "id";
  String recapNotecolName = "name";
  String recapNotecolUsername = "username";
  String recapNotecolEmail = "email";
  String recapNotecolFavoriteSerie = "favoriteSerie";
  String recapNotecolPassword = "password";

  String recapNotecolGaction = "GenreAction";
  String recapNotecolGadventure = "GenreAdventure";
  String recapNotecolGcomedy = "GenreComedy";
  String recapNotecolGdrama = "GenreDrama";
  String recapNotecolGfantasy = "GenreFantasy";
  String recapNotecolGhorror = "GenreHorror";
  String recapNotecolGmusical = "GenreMusical";

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "notes.db";

    Database notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $recapNoteTable ($recapNotecolId INTEGER PRIMARY KEY AUTOINCREMENT, $recapNotecolName TEXT, $recapNotecolUsername TEXT, $recapNotecolEmail TEXT, $recapNotecolFavoriteSerie TEXT, $recapNotecolPassword TEXT, $recapNotecolGaction INTEGER, $recapNotecolGadventure INTEGER, $recapNotecolGcomedy INTEGER, $recapNotecolGdrama INTEGER, $recapNotecolGfantasy INTEGER, $recapNotecolGhorror INTEGER, $recapNotecolGmusical INTEGER)");
  }

  Future<int> insertNote(RecapNote note) async {
    Database db = await this.database;
    int result = await db.insert(recapNoteTable, note.toMap());
    notify();
    return result;
  }

  Future<int> deleteNote(int noteId) async {
    Database db = await this.database;
    int result = await db
        .rawDelete("DELETE FROM $recapNoteTable WHERE $recapNotecolId=$noteId");
    notify();
    return result;
  }

  Future<int> updateNote(int noteId, RecapNote note) async {
    Database db = await this.database;
    var result = await db.update(
      recapNoteTable,
      note.toMap(),
      where: "$recapNotecolId = ?",
      whereArgs: [noteId],
    );
    notify();
    return result;
  }

  //static StreamController _controller;
  static StreamController<dynamic> _controller =
      StreamController<dynamic>.broadcast();
  dispose() {
    if (!_controller.hasListener) {
      _controller.close();
      _controller = null;
    }
  }

  Stream get stream {
    if (_controller == null) {
      _controller = StreamController();
    }
    return _controller.stream.asBroadcastStream();
  }

  Future<List<dynamic>> getNoteList() async {
    Database db = await this.database;
    var noteMapList = await db.rawQuery("SELECT * FROM $recapNoteTable");

    List<RecapNote> noteList = [];
    List<int> idList = [];

    for (int i = 0; i < noteMapList.length; i++) {
      RecapNote note = RecapNote.fromMap(noteMapList[i]);
      note.dataLocation = 1;
      noteList.add(note);
      idList.add(noteMapList[i]["id"]);
    }
    return [noteList, idList];
  }

  notify() async {
    if (_controller != null) {
      var response = await getNoteList();
      _controller.sink.add(response);
    }
  }
}

main() {
  //var response = DatabaseLocalServer.helper.getNoteList();
  //print(response[1]);
}
