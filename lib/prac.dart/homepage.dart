import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Categories/edit.dart';
import 'package:flutter_course/note/view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isloading = true;

  List<QueryDocumentSnapshot> data = [];
  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("categories")
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
          Navigator.of(context).pushNamed("addcategory");
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Homepage",
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
      body: isloading == true
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 170),
              itemBuilder: (context, i) {
                return InkWell(
                  
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  Noteview(categoryid: data[i].id)));
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
                              .doc(data[i].id)
                              .delete();
                            
                          Navigator.of(context)
                            .pushReplacementNamed("homepage");
                        },
                        
                        btnOkText: "Update",
                        btnOkOnPress: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditCategory(
                                docid: data[i].id, oldname: data[i]['name']),
                          ));
                        }).show();
                       
                  },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Image.asset(
                            "images/img1.jpg",
                            height: 100,
                          ),
                          Text("${data[i]['name']}"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
