import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Categories/customtexformfieldadd.dart';
import 'package:flutter_course/components/customButton.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

GlobalKey<FormState> gkey = GlobalKey<FormState>();

class _AddCategoryState extends State<AddCategory> {
  TextEditingController name = TextEditingController();

  
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');


bool isLoading = false;
  addcategory() async {
    if (gkey.currentState!.validate()) {
      try {
        isLoading=true;
            setState(() {
            });
           // await Future.delayed(Duration(seconds: 2));
        DocumentReference response = await categories.add(
            {"name": name.text, "id": FirebaseAuth.instance.currentUser!.uid});
        Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route)=>false);
        
      } catch (e) {
        isLoading=false;
        setState(() {
          
        });
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Category",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: isLoading==true? const Center(child: CircularProgressIndicator(),):
       Form(
        key: gkey,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              title: "Add",
              onPressed: () {
                addcategory();
              },

            )
          ],
        ),
      ),
    );
  }
}
