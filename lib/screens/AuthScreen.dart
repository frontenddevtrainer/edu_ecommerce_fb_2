import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLogin = false;

  Future<User?> signup() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: _email.text.trim(), password: _password.text.trim());
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

  Future<User?> signin() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _email.text.trim(), password: _password.text.trim());
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_isLogin ? "Login" : "Sign Up")),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                obscureText: true,
                controller: _password,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (_isLogin) {
                          signin();
                        } else {
                          signup();
                        }
                      },
                      child: Text(_isLogin ? "Login" : "Sign Up")),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin ? "Sign Up" : "Login"))
                ],
              )
            ]),
          ),
        ));
  }
}
