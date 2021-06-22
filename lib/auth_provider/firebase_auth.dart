import 'package:teste/data/web_server/FirebaseRemoteServer.dart';
import 'package:teste/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<UserModel> get user {
    return _firebaseAuth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(user.uid) : null;
  }

  Future<UserModel> signInAnonimo() async {
    UserCredential authResult = await _firebaseAuth.signInAnonymously();
    User user = authResult.user;
    // user.
    return UserModel(user.uid);
  }

  signInWithEmailAndPassword({String email, String password}) async {
    UserCredential authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    User user = authResult.user;
    return UserModel(user.uid);
  }

  createUserWithEmailAndPassword({
    String realusername,
    String email,
    String password,
    String favoriteSerie,
    bool action,
    bool adventure,
    bool comedy,
    bool drama,
    bool fantasy,
    bool horror,
    bool musical,
  }) async {
    UserCredential authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    User user = authResult.user;

    // Invocação ao Firestore para inserir o usuário.
    FirebaseRemoteServer.helper.includeUserData(
        user.uid,
        realusername,
        email,
        favoriteSerie,
        action,
        adventure,
        comedy,
        drama,
        fantasy,
        horror,
        musical);
    return UserModel(user.uid);
  }

  signOut() async {
    await _firebaseAuth.signOut();
  }
}
