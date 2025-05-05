import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Categories/customtexformfieldadd.dart';
import 'package:flutter_course/components/customButton.dart';
import 'package:flutter_course/note/view.dart';

class EditNote extends StatefulWidget {
  final String notedocid;
  final String value;

  final String categorydocid;
  const EditNote({super.key, required this.notedocid, required this.categorydocid, required this.value});

  @override
  State<EditNote> createState() => _EditNoteState();
}

GlobalKey<FormState> gkey = GlobalKey<FormState>();

class _EditNoteState extends State<EditNote> {
  TextEditingController note = TextEditingController();

  bool isLoading = false;
  editNote() async {
    CollectionReference collectionNote = FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.categorydocid)
        .collection("notes");

    if (gkey.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        
            await collectionNote.doc(widget.notedocid).update({"notes": note.text});
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => Noteview(categoryid: widget.categorydocid)),
            );
            isLoading=false;
            setState(() {
              
            });
      } catch (e) {
        isLoading = false;
        setState(() {});
        print("Erros found.$e");
      }
    }
  }
  @override
  void initState() {
    note.text = widget.value;
    super.initState();
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
          "Edit Note",
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
                  Custombutton(
                    title: "Save",
                    onPressed: () {
                      editNote();
                    },
                  )
                ],
              ),
            ),
    );
  }
}
