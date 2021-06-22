import 'dart:async';
import 'package:flutter/material.dart';
import 'package:teste/model/recap_note.dart';
import 'package:teste/view/my_app_screen.dart';
import 'package:teste/view/tela2/StateModel.dart';
import 'package:teste/logic/monitor_db/monitor_db_state.dart';
import 'package:teste/logic/monitor_db/monitor_db_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste/logic/manage_db/manage_db_event.dart';
import 'package:teste/logic/manage_db/manage_firebase_db_bloc.dart';
import 'package:teste/model/controller.dart';

var estadosList;
int thisId;
String thisPoster = '';
String thisName = '';
String thisSinopse = '';
String username;
int thisSeasonsNumber;
RecapNote newReview = RecapNote();

class MainTela2 extends StatefulWidget {
  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<MainTela2> {
  double rating = 0;
  String comment = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonitorBlocSeasonsF, MonitorState>(
        builder: (context, state) {
      estadosList = state;
      return MaterialApp(
        theme: ThemeData(
            primaryColor: const Color(0xFFad636e),
            scaffoldBackgroundColor: const Color(0xFFc09f80)),
        title: "Avaliação",
        home: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  serieName(thisName),
                  SizedBox(height: 10),
                  seriePoster(thisPoster),
                  SizedBox(height: 10),
                  Center(
                      child: Container(
                    width: 400,
                    child: Column(
                      children: [
                        serieSinopseTitle(),
                        SizedBox(height: 8),
                        serieSinopse(thisSinopse),
                        SizedBox(height: 25),
                        serieReviewInsert(),
                        Container(
                          child: Slider(
                            value: rating,
                            onChanged: (newRating) {
                              var oldRating = newRating * 10;
                              var finalRating = oldRating.toInt();
                              newReview.rate = finalRating;
                              newReview.idSerie = thisId;
                              setState(
                                () => rating = newRating,
                              );
                            },
                            min: 0,
                            max: 10,
                            divisions: 20,
                            label: "$rating",
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Comentar",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Container(
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (text) {
                              newReview.username = username;
                              print(newReview.username);
                              comment = text;
                              newReview.comment = text;
                              newReview.idSerie = thisId;
                            },
                            onSaved: (value) {
                              newReview.username = username;
                              newReview.comment = value;
                              newReview.idSerie = thisId;
                            },
                            decoration: InputDecoration(
                              labelText: 'Deixe sua opinião',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                            child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF76323f),
                            onPrimary: Colors.white,
                          ),
                          onPressed: () {
                            BlocProvider.of<ManageFirebaseBloc>(context)
                                .add(SubmitReviewEvent(note: newReview));

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Avaliação Salva!!!"),
                              ),
                            );
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              setPageIndex(0);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()),
                              );
                            });
                          },
                          child: Text("ENVIAR",
                              style: TextStyle(color: Colors.white)),
                        )),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class SerieList extends StatefulWidget {
  @override
  _SerieListState createState() => _SerieListState();
}

class _SerieListState extends State<SerieList> {
  Repository repo = Repository();

  List<String> _states = ["Selecione uma temporada"];
  List<String> _lgas = ["Selecione um episódio"];
  String _selectedState = "Selecione uma temporada";
  String _selectedLGA = "Selecione um episódio";
  @override
  void initState() {
    _states = List.from(_states)..addAll(repo.getStates());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              icon: Icon(Icons.arrow_drop_down_outlined),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: const Color(0xFF565656)),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              isExpanded: true,
              items: _states.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        dropDownStringItem,
                        style: TextStyle(color: const Color(0xFF565656)),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                _onSelectedState(value);
                int t = convertInfo(value);
                newReview.season = t;
              },
              value: _selectedState,
            ),
            DropdownButton<String>(
              isExpanded: true,
              style: TextStyle(color: const Color(0xFF565656)),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              items: _lgas.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        dropDownStringItem,
                        style: TextStyle(color: const Color(0xFF565656)),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                _onSelectedLGA(value);
                int e = convertInfo(value);
                newReview.episodes = e;
              },
              value: _selectedLGA,
            ),
          ],
        ));
  }

  void _onSelectedState(String value) {
    setState(() {
      _selectedLGA = "Selecione um episódio";
      _lgas = ["Selecione um episódio"];
      _selectedState = value;
      _lgas = List.from(_lgas)..addAll(repo.getLocalByState(value));
    });
  }

  void _onSelectedLGA(String value) {
    setState(() {
      _selectedLGA = value;
    });
  }
}

class Repository {
  List<Map> getAll() => _infos;

  getLocalByState(String state) => _infos
      .map((map) => StateModel.fromJson(map))
      .where((item) => item.state == state)
      .map((item) => item.lgas)
      .expand((i) => i)
      .toList();

  List<String> getStates() => _infos
      .map((map) => StateModel.fromJson(map))
      .map((item) => item.state)
      .toList();

  List _infos = buttonList();
}

List<dynamic> buttonList() {
  List<dynamic> informations = [];

  List<dynamic> defineEps(int i) {
    var eps = [];
    for (int j = 0; j < i; j++) {
      int ep = j + 1;
      eps.add("$epº episódio");
    }
    return eps;
  }

  for (int i = 0; i < (thisSeasonsNumber); i++) {
    int n = listSeasonEp(i);

    int season = i + 1;
    var actualState = {
      "temporada": "$seasonª temporada",
      "episodios": defineEps(n),
    };
    informations.add(actualState);
  }

  return informations;
}

int listSeasonEp(int i) {
  var estados = estadosList.noteList;
  List<RecapNote> seasonepsinfo = estados;
  seasonepsinfo.removeWhere((item) => item.idSerie != thisId);
  int neps = seasonepsinfo[i].episodes;

  return neps;
}

setStates(
  actualUsername,
  actualId,
  actualPoster,
  actualName,
  actualSinopse,
  actualSeasonsNumber,
) {
  username = actualUsername;
  thisId = actualId;
  thisPoster = actualPoster;
  thisName = actualName;
  thisSinopse = actualSinopse;
  thisSeasonsNumber = actualSeasonsNumber;
}

Widget serieName(thisName) {
  return Center(
      child: Container(
          child: Text('$thisName',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ))));
}

Widget seriePoster(thisPoster) {
  return Center(
    child: Container(
      child: Image.asset(
        thisPoster,
        height: 300,
        width: 300,
      ),
    ),
  );
}

Widget serieSinopseTitle() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        "Descrição: ",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.start,
      ),
    ],
  );
}

Widget serieSinopse(thisSinopse) {
  return Text(
    '$thisSinopse',
    style: TextStyle(color: Colors.white),
    textAlign: TextAlign.justify,
  );
}

Widget serieReviewInsert() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Avalie a Série:",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 15),
          Flexible(child: Container(child: SerieList())),
        ],
      ),
      SizedBox(height: 15),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Dê uma nota:",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    ],
  );
}
