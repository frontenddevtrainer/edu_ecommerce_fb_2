import 'package:edu_ecommerce_fb_2/widgets/ProductList.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Homepage")),
      body: ProductListing(),
    );
  }
}
