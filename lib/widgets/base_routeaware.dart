import 'dart:ffi';

import 'package:edu_ecommerce_fb_2/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../route_observer.dart";

class BaseAuthentication extends StatefulWidget {
  const BaseAuthentication({super.key});

  @override
  State<BaseAuthentication> createState() => _BaseAuthenticationState();
}

class _BaseAuthenticationState extends State<BaseAuthentication>
    with RouteAware {
  late AuthService authService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authService = Provider.of<AuthService>(context);
    routeObserver.subscribe(this, ModalRoute.of<dynamic>(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPushNext() {
    _navigate();
  }

  @override
  void didPopNext() {
    _navigate();
  }

  void _navigate() {
    if (authService.currentUser == null) {
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, "/messages", (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
