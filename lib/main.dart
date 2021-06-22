import 'package:teste/logic/manage_auth/auth_bloc.dart';
import 'package:teste/view/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:teste/logic/manage_db/manage_local_db_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Launcher());
}

class Launcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: BlocProvider<ManageLocalBloc>(
        create: (context) => ManageLocalBloc(),
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: Wrapper()),
      ),
    );
  }
}
