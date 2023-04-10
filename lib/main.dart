import 'package:edu_ecommerce_fb_2/screens/AuthScreen.dart';
import 'package:edu_ecommerce_fb_2/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import "firebase_options.dart";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AuthScreen(),);
  }
}