import 'package:edu_ecommerce_fb_2/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isLogin = false;

  @override
  Widget build(BuildContext context) {
    AuthService _authService = Provider.of<AuthService>(context);

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
                          _authService.signin(_email, _password);
                        } else {
                          _authService.signup(_email, _password);
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
