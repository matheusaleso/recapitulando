import 'package:flutter/material.dart';

/*Filtra a lista de séries evitando que uma série nula seja criada*/
filtrar(stateSeries) {
  List series = [];
  for (var i = 0; i < stateSeries.length; i++) {
    if ((stateSeries[i].serieName != null)) {
      series.add(stateSeries[i]);
    }
  }
  return series;
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

/*Funções relacionadas ao cálculo das avaliações*/
List<double> defineRate(noteList, position) {
  var reviews = noteList;
  List<double> rates = [];
  for (int i = 0; i < reviews.length; i++) {
    if (reviews[i].idSerie == position) {
      double actualRate = reviews[i].rate.toDouble();
      actualRate = actualRate / 10;
      rates.add(actualRate);
    }
  }
  return rates;
}

double media(List<double> rates) {
  double sum = 0;
  for (int i = 0; i < rates.length; i++) {
    double rate = rates[i];
    sum = rate + sum;
  }
  double mean = sum / rates.length;
  return mean;
}

Widget calcularMedia(noteList, position) {
  List<double> notas = defineRate(noteList, position);
  double m = media(notas);
  String displaym;
  if (m >= 0) {
    displaym = m.toStringAsFixed(1);
  } else {
    displaym = "-";
  }
  return Text(
    "Avaliação Geral: $displaym",
    style: TextStyle(fontSize: 20, color: Colors.white),
  );
}

List<double> defineMyRate(noteList, userName, position) {
  var reviews = noteList;
  List<double> rates = [];
  for (int i = 0; i < reviews.length; i++) {
    if ((reviews[i].idSerie == position) && (reviews[i].username == userName)) {
      double actualRate = reviews[i].rate.toDouble();
      actualRate = actualRate / 10;
      rates.add(actualRate);
    }
  }
  return rates;
}

int convertInfo(value) {
  String nInfo = "";
  for (int i = 0; i < 3; i++) {
    if (((value[i] == "0") ||
        (value[i] == "1") ||
        (value[i] == "2") ||
        (value[i] == "3") ||
        (value[i] == "4") ||
        (value[i] == "5") ||
        (value[i] == "6") ||
        (value[i] == "7") ||
        (value[i] == "8") ||
        (value[i] == "9"))) {
      nInfo = nInfo + value[i];
    }
  }

  var myInt = int.parse(nInfo);

  return myInt;
}
