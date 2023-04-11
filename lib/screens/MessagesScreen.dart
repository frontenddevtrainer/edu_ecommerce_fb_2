import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Messages")),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[50],
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Text("Hello World!!!"),
                    ),
                  ),
                );
              },
            )),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(children: [
                const Expanded(
                    child: TextField(
                  decoration: InputDecoration(hintText: "Send message."),
                )),
                IconButton(onPressed: () => {}, icon: const Icon(Icons.send))
              ]),
            )
          ],
        )));
  }
}
