import 'dart:async';

import 'package:teste/auth_provider/firebase_auth.dart';
import 'package:teste/data/web_server/FirebaseRemoteServer.dart';
import 'package:teste/logic/manage_auth/auth_event.dart';
import 'package:teste/logic/manage_auth/auth_state.dart';
import 'package:teste/model/user.dart';
import 'package:bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseAuthenticationService _authenticationService;
  StreamSubscription _authenticationStream;

  AuthBloc() : super(Unauthenticated()) {
    _authenticationService = FirebaseAuthenticationService();

    _authenticationStream =
        _authenticationService.user.listen((UserModel userModel) {
      add(InnerServerEvent(userModel));
    });
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      if (event == null) {
        yield Unauthenticated();
      } else if (event is RegisterUser) {
        await _authenticationService.createUserWithEmailAndPassword(
          realusername: event.realusername,
          favoriteSerie: event.favoriteSerie,
          email: event.username,
          password: event.password,
          action: event.action,
          adventure: event.adventure,
          comedy: event.comedy,
          drama: event.drama,
          fantasy: event.fantasy,
          horror: event.horror,
          musical: event.musical,
        );
      } else if (event is LoginAnonymousUser) {
        await _authenticationService.signInAnonimo();
      } else if (event is LoginUser) {
        await _authenticationService.signInWithEmailAndPassword(
            email: event.username, password: event.password);
      } else if (event is InnerServerEvent) {
        if (event.userModel == null) {
          yield Unauthenticated();
        } else {
          FirebaseRemoteServer.uid = event.userModel.uid;
          yield Authenticated(user: event.userModel);
        }
      } else if (event is Logout) {
        await _authenticationService.signOut();
      }
    } catch (e) {
      yield AuthError(message: e.toString());
    }
  }
}
