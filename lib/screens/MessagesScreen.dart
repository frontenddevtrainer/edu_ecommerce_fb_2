import 'package:edu_ecommerce_fb_2/services/auth_service.dart';
import 'package:edu_ecommerce_fb_2/services/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ChatService chatService = Provider.of<ChatService>(context);
    AuthService authService = Provider.of<AuthService>(context);

    User? _user = authService.currentUser;

    return Scaffold(
        appBar: AppBar(title: const Text("Messages")),
        body: SafeArea(
            // bottom: false,
            child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  Map<dynamic, dynamic>? map = snapshot.data?.snapshot.value;
                  if (map != null) {
                    List<MapEntry<dynamic, dynamic>> list =
                        map.entries.toList();

                    list.sort((a, b) =>
                        a.value['timestamp'].compareTo(b.value['timestamp']));

                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final message = list[index].value;
                        final isMyMessage = message["user"] == _user?.uid;

                        return ListTile(
                          title: Align(
                            alignment: isMyMessage
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: isMyMessage
                                    ? Colors.blue[50]
                                    : Colors.green[50],
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Text(message["message"]),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              stream: chatService.messageStream,
            )),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(children: [
                Expanded(
                    child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(hintText: "Send message."),
                )),
                IconButton(
                    onPressed: () async {
                      await chatService.sendMessage(
                          _messageController.text, _user?.uid);
                      _messageController.clear();
                    },
                    icon: const Icon(Icons.send))
              ]),
            )
          ],
        )));
  }
}
