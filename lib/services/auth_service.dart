import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<User?> signup(email, password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim());
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

  Future<User?> signin(email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

  Future<void> signout(email, password) async {
    await _auth.signOut();
  }
}
