import 'package:teste/logic/manage_auth/auth_bloc.dart';
import 'package:teste/logic/manage_auth/auth_event.dart';
import 'package:teste/logic/manage_db/manage_db_event.dart';
import 'package:teste/logic/manage_db/manage_local_db_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste/model/recap_note.dart';

RecapNote newUser = new RecapNote();

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return registerFormulario(newUser);
  }

  Widget registerFormulario(RecapNote newUser) {
    final GlobalKey<FormState> formKey = new GlobalKey();
    final RegisterUser registerData = new RegisterUser();
    return Center(
      child: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Column(children: [
              username(registerData, newUser),
              SizedBox(height: 10),
              email(registerData, newUser),
              SizedBox(height: 10),
              favoriteSerie(registerData, newUser),
              SizedBox(height: 10),
              listGenres(newUser, registerData),
              SizedBox(height: 10),
              password(registerData, newUser),
              SizedBox(height: 10),
              subButtom(registerData, newUser, formKey, context),
            ])),
      ),
    );
  }
}

Widget username(RegisterUser registerData, RecapNote newUser) {
  return TextFormField(
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.white),
        labelText: "Nome de Usuário",
        prefixIcon: Icon(Icons.account_box_rounded),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    validator: (String inValue) {
      if (inValue.length < 1) {
        return "O nome de usuário não pode ser nulo!";
      }
      return null;
    },
    onSaved: (String inValue) {
      print(registerData.realusername);
      registerData.realusername = inValue;
      newUser.username = inValue;
      print(registerData.realusername);
    },
  );
}

Widget email(RegisterUser registerData, RecapNote newUser) {
  return TextFormField(
    style: TextStyle(color: Colors.white),
    onChanged: (text) {},
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.email_rounded),
      border: OutlineInputBorder(),
      labelStyle: TextStyle(color: Colors.white),
      labelText: 'E-mail',
      hintText: "none@none.com",
    ),
    validator: (String inValue) {
      if (inValue.length == 0) {
        return "Por favor, digite seu e-mail para continuar!";
      }
      return null;
    },
    onSaved: (String inValue) {
      newUser.email = inValue;
      registerData.username = inValue;
    },
  );
}

Widget favoriteSerie(RegisterUser registerData, RecapNote newUser) {
  return TextFormField(
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.white),
        labelText: "Série Favorita",
        prefixIcon: Icon(Icons.tv_rounded),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    validator: (String inValue) {
      if (inValue.length == 0) {
        return "Por favor, digite seu e-mail para continuar!";
      }
      return null;
    },
    onSaved: (String inValue) {
      newUser.favoriteSerie = inValue;
      registerData.favoriteSerie = inValue;
    },
  );
}

Widget password(RegisterUser registerData, RecapNote newUser) {
  return TextFormField(
    style: TextStyle(color: Colors.white),
    obscureText: true,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.lock_rounded),
      labelText: 'Senha',
      labelStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(),
    ),
    validator: (String inValue) {
      if (inValue.length < 1) {
        return "A senha não pode ser nula!";
      }
      return null;
    },
    onSaved: (String inValue) {
      newUser.password = inValue;
      registerData.password = inValue;
    },
  );
}

Widget subButtom(
    RegisterUser registerData, RecapNote newUser, formKey, context) {
  return ElevatedButton(
    onPressed: () {
      registerData.action = setFale(registerData.action);
      registerData.adventure = setFale(registerData.adventure);
      registerData.comedy = setFale(registerData.comedy);
      registerData.drama = setFale(registerData.drama);
      registerData.fantasy = setFale(registerData.fantasy);
      registerData.horror = setFale(registerData.horror);
      registerData.musical = setFale(registerData.musical);
      newUser.name = "padrão";
      if (formKey.currentState.validate()) {
        formKey.currentState.save();
        BlocProvider.of<AuthBloc>(context).add(registerData);
        BlocProvider.of<ManageLocalBloc>(context)
            .add(SubmitEvent(note: newUser));
      }
    },
    child: Text("Cadastrar!"),
    style: ElevatedButton.styleFrom(
      primary: const Color(0xFF76323f),
      onPrimary: Colors.white, // foreground
    ),
  );
}

Widget listGenres(RecapNote note, RegisterUser registerData) {
  return DefineGenres(note: note, registerData: registerData);
}

class DefineGenres extends StatefulWidget {
  DefineGenres({Key key, this.note, this.registerData}) : super(key: key);
  final RecapNote note;
  final RegisterUser registerData;

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
    return returnGenres(widget.note, widget.registerData);
  }

  Widget returnGenres(RecapNote note, RegisterUser registerData) {
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
                registerData.action = value;
                genres['action'] = value;

                newUser.action = boolToInt(value);
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
                registerData.adventure = value;
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
                registerData.comedy = value;
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
                registerData.drama = value;

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
                registerData.fantasy = value;
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
                registerData.horror = value;
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
                registerData.musical = value;
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

bool setFale(bool b) {
  if (b == null) {
    b = false;
    return b;
  } else {
    return b;
  }
}
