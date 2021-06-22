import 'package:teste/logic/manage_auth/auth_bloc.dart';
import 'package:teste/logic/manage_auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return signInFormulario();
  }

  Widget signInFormulario() {
    final GlobalKey<FormState> formKey = new GlobalKey();
    final LoginUser loginData = new LoginUser(); // evento;
    return Form(
        key: formKey,
        child: Column(children: [
          email(loginData),
          SizedBox(height: 10),
          /*TextFormField(
              initialValue: "",
              keyboardType: TextInputType.emailAddress,
              validator: (String inValue) {
                if (inValue.length == 0) {
                  return "Please enter username";
                }
                return null;
              },
              onSaved: (String inValue) {
                loginData.username = inValue;
              },
              decoration: InputDecoration(
                  hintText: "none@none.com",
                  labelText: "Username (eMail address)")),*/
          password(loginData),
          SizedBox(height: 10),
          loginButtom(formKey, context, loginData)
          /* TextFormField(
              initialValue: "",
              obscureText: true,
              validator: (String inValue) {
                if (inValue.length < 1) {
                  return "Password must be >=10 in length";
                }
                return null;
              },
              onSaved: (String inValue) {
                loginData.password = inValue;
              },
              decoration:
                  InputDecoration(hintText: "Password", labelText: "Password")),*/

          /*  ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(LoginAnonymousUser());
              },
              child: Text("SignInAnônimo!"))*/
        ]));
  }
}

Widget email(LoginUser loginData) {
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
      loginData.username = inValue;
    },
  );
}

Widget password(LoginUser loginData) {
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
      loginData.password = inValue;
    },
  );
}

Widget loginButtom(formKey, context, loginData) {
  return ElevatedButton(
    onPressed: () {
      if (formKey.currentState.validate()) {
        formKey.currentState.save();
        BlocProvider.of<AuthBloc>(context).add(loginData);
      }
    },
    child: Text("Entrar!"),
    style: ElevatedButton.styleFrom(
      primary: const Color(0xFF76323f),
      onPrimary: Colors.white, // foreground
    ),
  );
}
