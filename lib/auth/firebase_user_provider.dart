import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AlcoappMainFirebaseUser {
  AlcoappMainFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

AlcoappMainFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AlcoappMainFirebaseUser> alcoappMainFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<AlcoappMainFirebaseUser>(
        (user) => currentUser = AlcoappMainFirebaseUser(user));
