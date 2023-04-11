import 'package:firebase_database/firebase_database.dart';

class ChatService {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child("messages");

  Stream get messageStream => _dbRef.onValue;

  Future<void> sendMessage(message, user) async {
    await _dbRef.push().set(
        {'message': message, 'user': user, 'timestamp': ServerValue.timestamp});
  }
}
