import 'package:edu_ecommerce_fb_2/route_observer.dart';
import 'package:edu_ecommerce_fb_2/screens/AuthScreen.dart';
import 'package:edu_ecommerce_fb_2/screens/HomeScreen.dart';
import 'package:edu_ecommerce_fb_2/screens/MessagesScreen.dart';
import 'package:edu_ecommerce_fb_2/services/auth_service.dart';
import 'package:edu_ecommerce_fb_2/services/chat_service.dart';
import 'package:edu_ecommerce_fb_2/widgets/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import "firebase_options.dart";
import "package:flutter_gen/gen_l10n/app_localization.dart";

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
    return MultiProvider(
        providers: [
          Provider<ChatService>(
            create: (context) => ChatService(),
          ),
          Provider<AuthService>(
            create: (context) => AuthService(),
          )
        ],
        child: StreamBuilder(
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            return MaterialApp(
              supportedLocales: const [Locale("en"), Locale("fr")],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              initialRoute: "/base",
              routes: {
                "/base": (context) => const Base(),
                "/": (context) => const AuthScreen(),
                "/messages": (context) => MessagesScreen()
              },
              navigatorObservers: [routeObserver],
            );
          },
          stream: _auth.authStateChanges(),
        ));
  }
}
