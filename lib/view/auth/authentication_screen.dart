import 'package:teste/view/auth/register.dart';
import 'package:teste/view/auth/sign_in.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthenticationScreenStatex();
  }
}

class _AuthenticationScreenStatex extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xFFc09f80),
          body: TabBarView(
            children: [
              Register(),
              SignIn(),
            ],
          ),
          appBar: AppBar(
            backgroundColor: const Color(0xFF6b7a8f),
            title: Text("Configuração de Usuários"),
            bottom: TabBar(
              tabs: [Tab(text: "Novo Registro"), Tab(text: "Efetuar Login")],
            ),
          ),
        ));
  }
}
