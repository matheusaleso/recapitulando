import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste/logic/manage_auth/auth_bloc.dart';
import 'package:teste/logic/manage_auth/auth_event.dart';
import 'package:teste/logic/manage_db/manage_db_state.dart';
import 'package:teste/logic/manage_db/manage_firebase_db_bloc.dart';
import 'package:teste/logic/manage_db/manage_local_db_bloc.dart';
import 'package:teste/logic/manage_db/manage_remote_db_bloc.dart';
import 'package:teste/logic/monitor_db/monitor_db_bloc.dart';
import 'package:teste/view/tela1/tela1_main.dart';
import 'package:teste/view/tela2/tela2_main.dart';
import 'package:teste/view/tela3/tela3_main.dart';
import 'package:teste/view/tela4/tela4_main.dart';

int pageIndex = 0;
setPageIndex(pi) {
  pageIndex = pi;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MyBottomNavigationBar();
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBar createState() => _MyBottomNavigationBar();
}

class _MyBottomNavigationBar extends State<MyBottomNavigationBar> {
  var _currentPage = pageIndex;

  var _pages = [
    MainTela1(),
    MainTela2(),
    MainTela3(),
    MainTela4(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MonitorBloc()),
        BlocProvider(create: (_) => MonitorBlocSeries()),
        BlocProvider(create: (_) => MonitorBlocSeriesF()),
        BlocProvider(create: (_) => MonitorBlocSeasonsF()),
        BlocProvider(create: (_) => MonitorBlocReviews()),
        BlocProvider(create: (_) => MonitorBlocReviewsF()),
        BlocProvider(create: (_) => ManageLocalBloc()),
        BlocProvider(create: (_) => ManageRemoteBloc()),
        BlocProvider(create: (_) => ManageFirebaseBloc())
      ],
      child: BlocListener<ManageLocalBloc, ManageState>(
        listener: (context, state) {
          if (state is UpdateState) {
            setState(() {
              _currentPage = 3;
            });
          }
        },
        child: BlocListener<ManageRemoteBloc, ManageState>(
          listener: (context, state) {
            if (state is UpdateState) {
              setState(() {
                _currentPage = 3;
              });
            }
          },
          child: BlocListener<ManageFirebaseBloc, ManageState>(
            listener: (context, state) {
              if (state is UpdateState) {
                setState(() {
                  _currentPage = 3;
                });
              }
            },
            child: Scaffold(
              body: _pages[_currentPage],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      backgroundColor: const Color(0xFF6b7a8f),
                      icon: Icon(Icons.apps_rounded),
                      label: "CATÁLOGO"),
                  BottomNavigationBarItem(
                      backgroundColor: const Color(0xFF6b7a8f),
                      icon: Icon(Icons.movie_filter_rounded),
                      label: "AVALIAR SÉRIE"),
                  BottomNavigationBarItem(
                      backgroundColor: const Color(0xFF6b7a8f),
                      icon: Icon(Icons.perm_device_info_rounded),
                      label: "INFORMAÇÕES"),
                  BottomNavigationBarItem(
                      backgroundColor: const Color(0xFF6b7a8f),
                      icon: Icon(Icons.account_box),
                      label: "ALTERAR"),
                ],
                currentIndex: _currentPage,
                onTap: (int novoIndex) {
                  setState(() {
                    _currentPage = novoIndex;
                  });
                },
                backgroundColor: const Color(0xFF6b7a8f),
                selectedItemColor: Colors.white,
              ),
              appBar: AppBar(
                backgroundColor: const Color(0xFF6b7a8f),
                title: mainTitle(),
                actions: [
                  TextButton.icon(
                      style: TextButton.styleFrom(primary: Colors.white),
                      icon: Icon(Icons.logout),
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(Logout());
                      },
                      label: Text("Logout"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget mainTitle() {
  return Row(children: [
    Text(
      "REC",
      style: TextStyle(color: Colors.red),
    ),
    Text(
      "apitulando",
      style: TextStyle(color: Colors.white),
    ),
    SizedBox(width: 5),
    Icon(Icons.adjust_rounded, color: Colors.white),
  ]);
}
