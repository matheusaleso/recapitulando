import 'package:flutter/material.dart';
import 'package:teste/logic/manage_db/manage_db_event.dart';
import 'package:teste/logic/manage_db/manage_db_state.dart';
import 'package:teste/logic/manage_db/manage_local_db_bloc.dart';
import 'package:teste/model/recap_note.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste/view/my_app_screen.dart';
import 'dart:async';

final GlobalKey<FormState> formKey = new GlobalKey();

class MainTela4 extends StatefulWidget {
  @override
  _MainTela3State createState() => _MainTela3State();
}

class _MainTela3State extends State<MainTela4> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageLocalBloc, ManageState>(builder: (context, state) {
      RecapNote newUser;
      if (state is UpdateState) {
        newUser = state.previousNote;
      } else {
        newUser = new RecapNote();
      }
      return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.lightGreen,
            scaffoldBackgroundColor: const Color(0xFFc09f80)),
        home: Scaffold(
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        nameFormField(newUser),
                        usernameFormField(newUser),
                        emailFormField(newUser),
                        serieFormField(newUser),
                        senhaFormField(newUser),
                        listGenres(newUser),
                        SizedBox(height: 10),
                        submitButton(newUser, state, context),
                        cancelButton(state, context)
                      ],
                    )),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget nameFormField(RecapNote note) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        initialValue: note.name,
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white),
            labelText: "Nome Completo",
            prefixIcon: Icon(Icons.mode_rounded),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        validator: (value) {
          if (value.length == 0) {
            return "Digite seu nome completo";
          }
          return null;
        },
        onSaved: (value) {
          note.name = value;
        },
      ),
    );
  }

  Widget usernameFormField(RecapNote note) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        initialValue: note.username,
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white),
            labelText: "Nome de Usuário",
            prefixIcon: Icon(Icons.account_box_rounded),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        validator: (value) {
          if (value.length == 0) {
            return "Digite seu nome de usuário!!!";
          }
          return null;
        },
        onSaved: (value) {
          note.username = value;
        },
      ),
    );
  }

  Widget emailFormField(RecapNote note) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value.length == 0) {
            return "Adicione um e-mail válido!";
          }
          return null;
        },
        onSaved: (value) {
          note.email = value;
        },
        style: TextStyle(color: Colors.white),
        initialValue: note.email,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white),
            labelText: "E-mail",
            prefixIcon: Icon(Icons.email_rounded),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        //controller: _mailInputController,
      ),
    );
  }

  Widget serieFormField(RecapNote note) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        initialValue: note.favoriteSerie,
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white),
            labelText: "Série Favorita",
            prefixIcon: Icon(Icons.tv_rounded),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        validator: (value) {
          if (value.length == 0) {
            return "Adicione uma série favorita!";
          }
          return null;
        },
        onSaved: (value) {
          note.favoriteSerie = value;
        },
      ),
    );
  }

  Widget senhaFormField(RecapNote note) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value.length == 0) {
            return "Adicione uma série";
          }
          return null;
        },
        onSaved: (value) {
          note.password = value;
        },
        // controller: _passwordInputController,
        obscureText: true,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white),
            labelText: "Senha",
            prefixIcon: Icon(Icons.lock_rounded),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  Widget submitButton(RecapNote note, state, context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color(0xFF76323f),
          onPrimary: Colors.white,
        ),
        child: (state is UpdateState
            ? Text("Atualizar Dados")
            : Text("CADASTRAR")),
        onPressed: () {
          if (formKey.currentState.validate()) {
            /*SignUpService().signUp(
              _mailInputController.text,
              _passwordInputController.text,
            );*/
            formKey.currentState.save();
            BlocProvider.of<ManageLocalBloc>(context)
                .add(SubmitEvent(note: note));

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Conta Criada!!!"),
              ),
            );
            Future.delayed(const Duration(milliseconds: 500), () {
              setPageIndex(0);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            });
          }
        });
  }

  Widget cancelButton(state, context) {
    return (state is UpdateState
        ? ElevatedButton(
            onPressed: () {
              BlocProvider.of<ManageLocalBloc>(context).add(UpdateCancel());
              setPageIndex(0);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            child: Text("Cancelar Atualização de Dados"))
        : Container());
  }
}

Widget listGenres(RecapNote note) {
  return DefineGenres(note: note);
}

class DefineGenres extends StatefulWidget {
  DefineGenres({Key key, this.note}) : super(key: key);
  final RecapNote note;

  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<DefineGenres> {
  Map<String, bool> genres = {
    'action': false,
    'adventure': false,
    'comedy': false,
    'drama': false,
    'fantasy': false,
    'horror': false,
    'musical': false,
  };

  int boolToInt(bool value) {
    if (value == true) {
      return 1;
    } else if (value == false) {
      return 0;
    } else {
      return -1;
    }
  }

  Widget build(BuildContext context) {
    return returnGenres(widget.note);
  }

  Widget returnGenres(RecapNote note) {
    genres['action'] = previousValue(note.action);
    genres['adventure'] = previousValue(note.adventure);
    genres['comedy'] = previousValue(note.comedy);
    genres['drama'] = previousValue(note.drama);
    genres['fantasy'] = previousValue(note.fantasy);
    genres['horror'] = previousValue(note.horror);
    genres['musical'] = previousValue(note.musical);

    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF7e6954)),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          CheckboxListTile(
            checkColor: Colors.white,
            activeColor: Colors.transparent,
            title: Text("Ação", style: TextStyle(color: Colors.white)),
            secondary:
                Icon(Icons.sports_kabaddi_rounded, color: Color(0xFF7e6954)),
            value: genres['action'],
            onChanged: (bool value) {
              setState(() {
                genres['action'] = value;
                note.action = boolToInt(value);
              });
            },
          ),
          CheckboxListTile(
            checkColor: Colors.white,
            activeColor: Colors.transparent,
            title: Text("Aventura", style: TextStyle(color: Colors.white)),
            secondary: Icon(Icons.wb_twighlight, color: Color(0xFF7e6954)),
            value: genres['adventure'],
            onChanged: (bool value) {
              setState(() {
                genres['adventure'] = value;
                note.adventure = boolToInt(value);
              });
            },
          ),
          CheckboxListTile(
            checkColor: Colors.white,
            activeColor: Colors.transparent,
            title: Text("Comédia", style: TextStyle(color: Colors.white)),
            secondary: Icon(Icons.mood_rounded, color: Color(0xFF7e6954)),
            value: genres['comedy'],
            onChanged: (bool value) {
              setState(() {
                genres['comedy'] = value;
                note.comedy = boolToInt(value);
              });
            },
          ),
          CheckboxListTile(
            checkColor: Colors.white,
            activeColor: Colors.transparent,
            title: Text("Drama", style: TextStyle(color: Colors.white)),
            secondary: Icon(Icons.mood_bad_rounded, color: Color(0xFF7e6954)),
            value: genres['drama'],
            onChanged: (bool value) {
              setState(() {
                genres['drama'] = value;
                note.drama = boolToInt(value);
              });
            },
          ),
          CheckboxListTile(
            checkColor: Colors.white,
            activeColor: Colors.transparent,
            title: Text("Fantasia", style: TextStyle(color: Colors.white)),
            secondary: Icon(Icons.landscape_rounded, color: Color(0xFF7e6954)),
            value: genres['fantasy'],
            onChanged: (bool value) {
              setState(() {
                genres['fantasy'] = value;
                note.fantasy = boolToInt(value);
              });
            },
          ),
          CheckboxListTile(
            checkColor: Colors.white,
            activeColor: Colors.transparent,
            title: Text("Terror", style: TextStyle(color: Colors.white)),
            secondary:
                Icon(Icons.local_movies_rounded, color: Color(0xFF7e6954)),
            value: genres['horror'],
            onChanged: (bool value) {
              setState(() {
                genres['horror'] = value;
                note.horror = boolToInt(value);
              });
            },
          ),
          CheckboxListTile(
            checkColor: Colors.white,
            activeColor: Colors.transparent,
            title: Text("Musical", style: TextStyle(color: Colors.white)),
            secondary:
                Icon(Icons.library_music_rounded, color: Color(0xFF7e6954)),
            value: genres['musical'],
            onChanged: (bool value) {
              setState(() {
                note.musical = boolToInt(value);
                genres['musical'] = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

bool previousValue(int newUserValue) {
  if (newUserValue != null) {
    bool newValue = intToBool(newUserValue);
    return newValue;
  } else {
    return true;
  }
}

bool intToBool(iValue) {
  if (iValue == 1) {
    return true;
  } else {
    return false;
  }
}
