import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class testpage extends StatefulWidget {
  const testpage({super.key});

  @override
  State<testpage> createState() => _testpageState();
}

class _testpageState extends State<testpage> {
  File? file;
  String? url;
  getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagecamera =
        await picker.pickImage(source: ImageSource.camera);
    if (imagecamera != null) {
      file = File(imagecamera!.path);

      var imagename = basename(imagecamera!.path);

      var refstorage = FirebaseStorage.instance.ref("images/$imagename");
      await refstorage.putFile(file!);
      url = await refstorage.getDownloadURL();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
      ),
      body: Container(
        child: Column(
          children: [
            MaterialButton(
                //padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Get Image Camera",
                ),
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () async {
                  await getImage();
                }),
            if (url != null)
              Image.network(
                url!,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
          ],
        ),
      ),
    );
  }
}
