import 'package:edu_ecommerce_fb_2/widgets/ProductList.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
              },
              icon: const Icon(Icons.abc))
        ],
      ),
      body: ProductListing(),
    );
  }
}
