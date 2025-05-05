import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Categories/customtexformfieldadd.dart';
import 'package:flutter_course/components/customButton.dart';
import 'package:flutter_course/note/view.dart';
import 'package:image_picker/image_picker.dart';

class AddNote extends StatefulWidget {
  final String docid;
  const AddNote({super.key, required this.docid});

  @override
  State<AddNote> createState() => _AddNoteState();
}

GlobalKey<FormState> gkey = GlobalKey<FormState>();

class _AddNoteState extends State<AddNote> {
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

  TextEditingController note = TextEditingController();

  bool isLoading = false;
  addNote(context) async {
    CollectionReference collectionNote = FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.docid)
        .collection("notes");

    if (gkey.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        DocumentReference response =
            await collectionNote.add({"notes": note.text,"url": url ?? "None"});
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => Noteview(categoryid: widget.docid)),
        );
        isLoading = false;
        setState(() {});
      } catch (e) {
        isLoading = false;
        setState(() {});
        print("Erros found.$e");
      }
    }
  }

  @override
  void dispose() {
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Note",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: gkey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: CustomTextFormAdd(
                        hintText: "Enter Your Note",
                        myController: note,
                        validator: (val) {
                          if (val == "") {
                            return "Can't be empty";
                          } else {}
                          return null;
                        }),
                  ),
                  CustombuttonUpload(
                    title: "Upload Image",
                    isSelected: url == null ? false : true,
                    onPressed: () async {
                      await getImage();
                    },
                  ),
                  Custombutton(
                    title: "Add",
                    onPressed: () {
                      addNote(context);
                    },
                  )
                ],
              ),
            ),
    );
  }
}
