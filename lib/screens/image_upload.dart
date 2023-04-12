import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key});

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  String? _imageUrl;
  File? _image;

  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> _pick() async {
    try {
      final XFile? selected = await _picker.pickImage(
          source: ImageSource.camera, maxHeight: 1000, maxWidth: 1000);
      setState(() {
        _image = File(selected!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _upload() async {
    if (_image == null) {
      return;
    }

    try {
      final ref = _firebaseStorage.ref().child("images").child("profile.jpg");
      await ref.putFile(_image!);
      final String url = await ref.getDownloadURL();
      setState(() {
        _imageUrl = url;
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.hello_world)),
      body: SingleChildScrollView(
          child: Column(
        children: [
          // Row(
          //   children: const [
          //     Flexible(child: Text("dkajhdahdjkahkjdakdhakhdjkaPfor")),
          //     Flexible(child: Text("dkajhdahdjkahkjdakdhakhdjkaPfor")),
          //     Flexible(child: Text("dkajhdahdjkahkjdakdhakhdjkaPfor")),
          //     Flexible(child: Text("dkajhdahdjkahkjdakdhakhdjkaPfor")),
          //   ],
          // ),
          _image != null ? Image.file(_image!) : const Text("No file found"),
          TextButton(
              onPressed: () {
                _pick();
              },
              child: const Text("Pick Image")),
          TextButton(
              onPressed: () {
                _upload();
              },
              child: const Text("Upload Image")),
          _imageUrl != null
              ? Text(_imageUrl.toString())
              : const Text("not uploaded.")
        ],
      )),
    ));
  }
}
