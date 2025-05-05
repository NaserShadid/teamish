import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Categories/customtexformfieldadd.dart';
import 'package:flutter_course/components/customButton.dart';

class EditCategory extends StatefulWidget {
  
  final String docid;
  final String oldname;

  const EditCategory({super.key, required this.docid, required this.oldname});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

GlobalKey<FormState> gkey = GlobalKey<FormState>();

class _EditCategoryState extends State<EditCategory> {

  TextEditingController name = TextEditingController();
  CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  bool isLoading = false;

  editCategory() async {
    if (gkey.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        await categories.doc(widget.docid).set({
          "name": name.text,
        },SetOptions(merge: true));
        Navigator.of(context)
            .pushNamedAndRemoveUntil("homepage", (route) => false);
      } catch (e) {
        isLoading = false;
        setState(() {});
        print("Erros found.$e");
      }
    }
  }
@override
  void dispose() {
    name.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    name.text=widget.oldname;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Category",
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
                        hintText: "Enter Name",
                        myController: name,
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
                      editCategory();
                    },
                  )
                ],
              ),
            ),
    );
  }
}
