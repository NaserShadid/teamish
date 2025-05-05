import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Categories/edit.dart';
import 'package:flutter_course/note/add.dart';
import 'package:flutter_course/note/edit.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Noteview extends StatefulWidget {
  final String categoryid;

  const Noteview({super.key, required this.categoryid});

  @override
  State<Noteview> createState() => _NoteviewState();
}

class _NoteviewState extends State<Noteview> {
  bool isloading = true;

  List<QueryDocumentSnapshot> data = [];
  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.categoryid)
        .collection("notes")
        .get();

    // await Future.delayed(Duration(seconds: 2));
    data.addAll(querySnapshot.docs);
    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddNote(docid: widget.categoryid)));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: Text(
            "Note Page",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  googleSignIn.disconnect();
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("login", (route) => false);
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: WillPopScope(
          child: isloading == true
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 170),
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditNote(
                                notedocid: data[i].id,
                                categorydocid: widget.categoryid,
                                value: data[i]['notes'])));
                      },
                      onLongPress: () {
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'Alert',
                            desc: 'Choose the Action you want to take ',
                            btnCancelText: "Delete",
                            btnCancelOnPress: () async {
                              await FirebaseFirestore.instance
                                  .collection("categories")
                                  .doc(widget.categoryid)
                                  .collection("notes")
                                  .doc(data[i].id)
                                  .delete();

                                  if(data[i]['url']!="none"){
                                    FirebaseStorage.instance.refFromURL(data[i]['url']).delete();
                                  }
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      Noteview(categoryid: widget.categoryid)));
                            },
                            btnOkText: "Update",
                            btnOkOnPress: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditNote(
                                      notedocid: data[i].id,
                                      categorydocid: widget.categoryid,
                                      value: data[i]['notes'])));
                            }).show();
                      },
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [ 
                              Text("${data[i]['notes']}"),
                              if(data[i]['url']!="none")
                              Image.network(data[i]['url'],height: 70,),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
          onWillPop: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              "homepage",
              (route) => false,
            );
            return Future.value(false);
          },
        ));
  }
}
