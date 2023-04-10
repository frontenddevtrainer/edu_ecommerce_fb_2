import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class ProductListing extends StatelessWidget {
  ProductListing({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<dynamic>> fetchProducts() async {
    QuerySnapshot querySnapshot = await _firestore.collection("products").get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  Widget createListing(
      BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final product = snapshot.data![index];

          return ListTile(
            title: Text(product["name"]),
          );
        },
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      builder: createListing,
      future: fetchProducts(),
    );
  }
}
