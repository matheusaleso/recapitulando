import 'package:teste/model/user.dart';

abstract class AuthEvent {}

class RegisterUser extends AuthEvent {
  String username;
  String password;
  String realusername;
  String favoriteSerie;
  bool action;
  bool adventure;
  bool comedy;
  bool drama;
  bool fantasy;
  bool horror;
  bool musical;
}

class LoginUser extends AuthEvent {
  String username;
  String password;
}

class LoginAnonymousUser extends AuthEvent {}

class Logout extends AuthEvent {}

class InnerServerEvent extends AuthEvent {
  final UserModel userModel;
  InnerServerEvent(this.userModel);
}
