import 'package:edu_ecommerce_fb_2/screens/AuthScreen.dart';
import 'package:edu_ecommerce_fb_2/screens/MessagesScreen.dart';
import 'package:edu_ecommerce_fb_2/services/auth_service.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    if (user == null) {
      return const AuthScreen();
    } else {
      return MessagesScreen();
    }
  }
}
