import 'package:edu_ecommerce_fb_2/screens/AuthScreen.dart';
import 'package:edu_ecommerce_fb_2/screens/HomeScreen.dart';
import 'package:edu_ecommerce_fb_2/screens/MessagesScreen.dart';
import 'package:edu_ecommerce_fb_2/services/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:provider/provider.dart';
import "firebase_options.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(Application());
}

class Application extends StatelessWidget {
  Application({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
          providers: [
            Provider<ChatService>(
              create: (context) => ChatService(),
            )
          ],
          child: StreamBuilder(
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                final User? user = snapshot.data;
                return user == null ? const AuthScreen() : MessagesScreen();
              }
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
            stream: _auth.authStateChanges(),
          )),
    );
  }
}
