import 'package:flutter/material.dart';
import 'package:teste/view/tela2/tela2_main.dart';
import 'package:teste/view/my_app_screen.dart';
import 'package:teste/logic/monitor_db/monitor_db_state.dart';
import 'package:teste/logic/monitor_db/monitor_db_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:teste/model/controller.dart';

String username;

class MainTela1 extends StatefulWidget {
  @override
  _MainTela1State createState() => _MainTela1State();
}

class _MainTela1State extends State<MainTela1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.lightGreen,
            scaffoldBackgroundColor: const Color(0xFFc09f80)),
        title: "Séries",
        home: Scaffold(
          body: MySeriePage(),
        ));
  }
}

class MySeriePage extends StatefulWidget {
  MySeriePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MySeriePageState createState() => _MySeriePageState();
}

class _MySeriePageState extends State {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonitorBloc, MonitorState>(
        builder: (context, stateLocal) {
      return BlocBuilder<MonitorBlocSeriesF, MonitorState>(
          builder: (context, stateSeries) {
        return BlocBuilder<MonitorBlocReviewsF, MonitorState>(
            builder: (context, stateReviews) {
          return Scaffold(
              body: listSeriesContet(context, stateLocal, stateSeries.noteList,
                  stateReviews.noteList, stateSeries.idList));
        });
      });
    });
  }
}

Widget listSeriesContet(
    BuildContext context, stateLocal, noteList, stateReviews, idList) {
  username = getThisUsername(stateLocal);
  var series = filtrar(noteList);
  return GridView.count(
    crossAxisCount: 2,
    children: [
      for (var i = 0; i < series.length; i++)
        Series(serieId: i, noteList: series, stateReviews: stateReviews),
    ],
  );
}

class Series extends StatefulWidget {
  final int serieId;
  final noteList;
  final stateReviews;
  Series({Key key, this.serieId, this.noteList, this.stateReviews})
      : super(key: key);

  @override
  _SeriesState createState() => _SeriesState();
}

class _SeriesState extends State<Series> {
  Widget build(BuildContext context) {
    return createSerie(widget.serieId, widget.noteList, widget.stateReviews);
  }

  Widget createSerie(int i, noteList, stateReviews) {
    String createSerieposter = noteList[i].seriePoster;
    String createSeriename = noteList[i].serieName;

    return Card(
      color: const Color(0xFFc09f80),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                seriePoster(createSerieposter),
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: calcularMedia(stateReviews, i),
                ),
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: yourRate(stateReviews, username, i),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: serieGenre(noteList, i),
                ),
              ],
            ),
          ),
          Column(children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                '$createSeriename',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ]),
          InkWell(
            onTap: () {
              _showMyClassListDialog(context, i, noteList);
            },
          ),
        ],
      ),
    );
  }
}

Widget seriePoster(createSerieposter) {
  return Container(
    child: Image.asset(
      createSerieposter ?? 'assets/images/xena.jpg',
    ),
  );
}

Widget yourRate(noteList, username, position) {
  List<double> myrates = defineMyRate(noteList, username, position);
  double m = media(myrates);
  String displaym;
  if (m >= 0) {
    displaym = m.toStringAsFixed(1);
  } else {
    displaym = "-";
  }

  return Text(
    "Sua Avaliação: $displaym",
    style: TextStyle(fontSize: 20, color: Colors.white),
  );
}

Widget serieGenre(noteList, position) {
  var genre = noteList[position].serieGenre;
  return Text(
    "Gênero: $genre" ?? "Sem Gênero",
    style: TextStyle(fontSize: 15, color: Colors.white),
  );
}

Future<void> _showMyClassListDialog(context, int i, noteList) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Sinopse'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(noteList[i].serieSinopse),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Avaliar Série'),
            onPressed: () {
              setPageIndex(1);
              print(username);
              setStates(
                username,
                noteList[i].idSerie,
                noteList[i].seriePoster,
                noteList[i].serieName,
                noteList[i].serieSinopse,
                noteList[i].numberSeasons,
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
          TextButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

/*Localiza o username atual*/
String getThisUsername(stateLocal) {
  var nStates = stateLocal.noteList;
  int cont = 0;
  for (var id in nStates) {
    if (id.dataLocation == 1) {
      cont += 1;
    }
  }
  int size = 0;
  if (size != 0) {
    size = cont - 1;
  }
  return nStates[size].username;
}
