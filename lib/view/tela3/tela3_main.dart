import 'package:teste/logic/manage_db/manage_db_event.dart';
import 'package:teste/logic/manage_db/manage_local_db_bloc.dart';
import 'package:teste/logic/manage_db/manage_remote_db_bloc.dart';
import 'package:teste/logic/manage_db/manage_firebase_db_bloc.dart';
import 'package:teste/logic/monitor_db/monitor_db_state.dart';
import 'package:teste/logic/monitor_db/monitor_db_bloc.dart';
import 'package:teste/model/recap_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainTela3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return __RecapNoteListState();
  }
}

class __RecapNoteListState extends State<MainTela3> {
  List colorLocation = [Colors.red, Colors.blue, Colors.yellow];
  List iconLocation = [
    Icons.error_outline,
    Icons.settings_cell,
    Icons.network_check_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonitorBloc, MonitorState>(builder: (context, state) {
      return BlocBuilder<MonitorBlocSeriesF, MonitorState>(
          builder: (context, stateSeries) {
        return Column(
          children: <Widget>[
            Expanded(child: content(stateSeries)),
            Expanded(child: getNoteListView(state.noteList, state.idList)),
          ],
        );
        // return getNoteListView(state.noteList, state.idList);
      });
    });
  }

  getNoteListView(noteList, idList) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, position) {
        return Column(
          children: [
            Card(
              color: colorLocation[noteList[position].dataLocation],
              elevation: 4,
              child: Column(
                children: [
                  ListTile(
                    leading:
                        Icon(iconLocation[noteList[position].dataLocation]),
                    title: Text(noteList[position].username ?? "Texto Padrão"),
                    subtitle: Text(noteList[position].email ?? "Texto Padrão"),
                    onTap: () {
                      if (noteList[position].dataLocation == 1) {
                        BlocProvider.of<ManageLocalBloc>(context).add(
                            UpdateRequest(
                                noteId: idList[position],
                                previousNote: RecapNote.fromMap(
                                    noteList[position].toMap())));
                      } else if (noteList[position].dataLocation == 2) {
                        BlocProvider.of<ManageRemoteBloc>(context).add(
                            UpdateRequest(
                                noteId: idList[position],
                                previousNote: RecapNote.fromMap(
                                    noteList[position].toMap())));
                      } else if (noteList[position].dataLocation == 0) {
                        BlocProvider.of<ManageFirebaseBloc>(context).add(
                            UpdateRequest(
                                noteId: idList[position],
                                previousNote: RecapNote.fromMap(
                                    noteList[position].toMap())));
                      }
                    },
                    trailing: GestureDetector(
                        onTap: () {
                          if (noteList[position].dataLocation == 1) {
                            BlocProvider.of<ManageLocalBloc>(context)
                                .add(DeleteEvent(noteId: idList[position]));
                          } else if (noteList[position].dataLocation == 2) {
                            BlocProvider.of<ManageRemoteBloc>(context)
                                .add(DeleteEvent(noteId: idList[position]));
                          }
                        },
                        child: Icon(Icons.delete)),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget content(state) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('reviews').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return LinearProgressIndicator();
            break;
          default:
            return ListView(
              children: snapshot.data.docs.map<Widget>((DocumentSnapshot doc) {
                int idReview = doc['idReview'];
                int idSerie = doc['idSerie'];
                String serie = getThisSerieName(idSerie, state);
                int episodio = doc['episodes'];
                int temporada = doc['season'];
                int rate = doc['rate'];
                double rateD = rate.toDouble() / 10;
                return ListTile(
                  trailing: Icon(Icons.comment_rounded, size: 50),
                  title: Text("Avaliação: $idReview" ?? "ERRO"),
                  subtitle: Column(
                    children: [
                      Text("Série: $serie" ?? "Erro"),
                      Text("Temporada: $temporada" ?? "Erro"),
                      Text("Episódio: $episodio" ?? "Erro"),
                      Text("Avaliação: $rateD" ?? "Erro"),
                      Text("Comentário:" + doc['comment'] ?? "Erro"),
                      Text("Avaliação de:" + doc['username'] ?? "Erro"),
                    ],
                  ),
                );
              }).toList(),
            );
        }
      },
    ),
  );
}

/*Localiza o username atual*/
String getThisSerieName(int id, stateSeries) {
  String serie;
  for (var i in stateSeries.noteList) {
    if (i.idSerie == id) {
      serie = i.serieName;
    }
  }

  return serie;
}
