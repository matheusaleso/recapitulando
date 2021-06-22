import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teste/model/recap_note.dart';

class FirebaseRemoteServer {
  static String uid;
  static FirebaseRemoteServer helper = FirebaseRemoteServer._createInstance();
  FirebaseRemoteServer._createInstance();

  final CollectionReference noteCollection =
      FirebaseFirestore.instance.collection("usuarios");

  includeUserData(
    String uid,
    String realusername,
    String email,
    String favoriteSerie,
    bool action,
    bool adventure,
    bool comedy,
    bool drama,
    bool fantasy,
    bool horror,
    bool musical,
  ) async {
    var firebaseResponse = await FirebaseRemoteServer.helper.getNoteList();
    int size = firebaseResponse[0].length;
    await noteCollection.doc("$size").set({
      "username": realusername,
      "email": email,
      "favoriteSerie": favoriteSerie,
      "action": action,
      "adventure": adventure,
      "comedy": comedy,
      "drama": drama,
      "fantasy": fantasy,
      "horror": horror,
      "musical": musical,
    });
  }

  List _noteListFromSnapshot(QuerySnapshot snapshot) {
    List<RecapNote> noteList = [];
    List<int> idList = [];

    for (var doc in snapshot.docs) {
      RecapNote note = RecapNote.fromMap(doc.data());
      int id;
      note.dataLocation = 0;
      noteList.add(note);
      if (doc.id.runtimeType == String) {
        id = int.parse(doc.id);
        idList.add(id);
      } else {
        idList.add(id);
      }
    }
    return [noteList, idList];
  }

  Future<List<dynamic>> getNoteList() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("usuarios").get();
    return _noteListFromSnapshot(querySnapshot);
  }

  Future<List<dynamic>> getNoteListSeries() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("series").get();
    return _noteListFromSnapshot(querySnapshot);
  }

  Future<List<dynamic>> getNoteListSeasons() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("seasons").get();
    //var list = querySnapshot.docs;
    return _noteListFromSnapshot(querySnapshot);
  }

  Future<List<dynamic>> getNoteListReviews() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("reviews").get();
    //var list = querySnapshot.docs;
    return _noteListFromSnapshot(querySnapshot);
  }

  insertNote(RecapNote note) async {
    await noteCollection
        .doc(uid)
        .collection("my_notes")
        .add({"title": note.name, "description": note.serieName});
  }

  insertReviewF(RecapNote note) async {
    var firebaseResponse =
        await FirebaseRemoteServer.helper.getNoteListReviews();
    int size = firebaseResponse[0].length + 10;
    FirebaseFirestore.instance.collection("reviews").doc("$size").set({
      "comment": note.comment,
      "episodes": note.episodes,
      "idReview": size,
      "idSerie": note.idSerie,
      "rate": note.rate,
      "season": note.season,
      "username": note.username,
    });
  }

  updateNote(String noteId, RecapNote note) async {
    await noteCollection
        .doc(uid)
        .collection("my_notes")
        .doc("$noteId")
        .update({"title": note.name, "description": note.email});
  }

  deleteNote(int noteId) async {
    await noteCollection
        .doc(uid)
        .collection("my_notes")
        .doc("$noteId")
        .delete();
  }

  /*
  Stream
  */
  Stream get stream {
    return noteCollection
        .doc(uid)
        .collection("my_notes")
        .snapshots()
        .map(_noteListFromSnapshot);
  }
}

//import 'package:firebase_core/firebase_core.dart';
/*
class FirebaseRemoteServer {
  static String uid;
  static FirebaseRemoteServer helper = FirebaseRemoteServer._createInstance();
  FirebaseRemoteServer._createInstance();

  final CollectionReference noteCollection =
      FirebaseFirestore.instance.collection("series");

  includeUserData(String uid, String email, int idade) async {
    await noteCollection.doc(uid).set({"email": email, "idade": idade});
  }
  /*includeUserData(
      String uid,
      int idSerie,
      int numberEpisodes,
      int numberSeasons,
      String serieGenre,
      String serieName,
      String seriePoster,
      String serieSinopse) async {
    await noteCollection.doc(uid).set({
      "idSerie": idSerie,
      "numberEpisodes": numberEpisodes,
      "numberSeasons": numberSeasons,
      "serieGenre": serieGenre,
      "serieName": serieName,
      "seriePoster": seriePoster,
      "serieSinopse": serieSinopse,
    });
  } */

  List _noteListFromSnapshot(QuerySnapshot snapshot) {
    List<RecapNote> noteList = [];
    List<int> idList = [];

    for (var doc in snapshot.docs) {
      RecapNote note = RecapNote.fromMap(doc.data());
      int id;
      note.dataLocation = 0;
      noteList.add(note);
      if (doc.id.runtimeType == String) {
        id = int.parse(doc.id);
        idList.add(id);
      } else {
        idList.add(id);
      }

      //idList.add(doc.id);
    }
    return [noteList, idList];
  }

  Future<List<dynamic>> getNoteListSeries() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("series").get();
    //var list = querySnapshot.docs;
    return _noteListFromSnapshot(querySnapshot);
  }

  Future<List<dynamic>> getNoteListSeasons() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("seasons").get();
    //var list = querySnapshot.docs;
    return _noteListFromSnapshot(querySnapshot);
  }

  Future<List<dynamic>> getNoteListReviews() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("reviews").get();
    //var list = querySnapshot.docs;
    return _noteListFromSnapshot(querySnapshot);
  }

  insertNote(RecapNote note) async {
    await noteCollection
        .doc(uid)
        .collection("my_notes")
        .add({"title": note.name, "description": note.serieSinopse});
  }

  insertReviewF(RecapNote note) async {
    var firebaseResponse =
        await FirebaseRemoteServer.helper.getNoteListReviews();
    int size = firebaseResponse[0].length;
    FirebaseFirestore.instance.collection("reviews").doc("$size").set({
      "comment": note.comment,
      "episodes": note.episodes,
      "idReview": size,
      "idSerie": 0,
      "rate": note.rate,
      "season": note.season,
      "username": note.username,
    });
  }

  updateNote(String noteId, RecapNote note) async {
    await noteCollection
        .doc(uid)
        .collection("my_notes")
        .doc("$noteId")
        .update({"title": note.name, "description": note.serieSinopse});
  }

  deleteNote(int noteId) async {
    await noteCollection
        .doc(uid)
        .collection("my_notes")
        .doc("$noteId")
        .delete();
  }

  /*
  Stream
  */
  Stream get stream {
    return noteCollection
        .doc(uid)
        .collection("series")
        .snapshots()
        .map(_noteListFromSnapshot);
  }
}*/
