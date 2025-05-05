import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Categories/add.dart';

class FilterFireStore extends StatefulWidget {
  const FilterFireStore({super.key});

  @override
  State<FilterFireStore> createState() => _FilterFireStoreState();
}

class _FilterFireStoreState extends State<FilterFireStore> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
  // List<QueryDocumentSnapshot> data = [];
  // intialdata() async {
  //   CollectionReference users = FirebaseFirestore.instance.collection("users");
  //   QuerySnapshot userdata =
  //       await users.orderBy("age",descending: true).get();
  //   for (var element in userdata.docs) {
  //     data.add(element);
  //   }
  //   setState(() {});
  // }

  @override
  void initState() {
    // intialdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        DocumentReference doc1 =
            FirebaseFirestore.instance.collection('users').doc("1");
        DocumentReference doc2 =
            FirebaseFirestore.instance.collection('users').doc("2");

        WriteBatch batch = FirebaseFirestore.instance.batch();
        batch.set(doc1, {
          "name": "mohammed",
          "age": 32,
          "money":450,
        });
        batch.set(doc2, {
          "name": "shady",
          "age": 22,
          "money":350,
        });

        batch.commit();
      }),
      body: Container
      (
        padding: EdgeInsets.all(10),
        child: StreamBuilder(stream: _usersStream,builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Text("Error");
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return Text("Loading... ");
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,i){
            return InkWell(
              onTap: () {
                DocumentReference documentReference = FirebaseFirestore.instance
                    .collection('users')
                    .doc(snapshot.data!.docs[i].id);

                FirebaseFirestore.instance.runTransaction((transaction) async {
                  DocumentSnapshot snapshot =
                      await transaction.get(documentReference);

                  if (snapshot.exists) {
                    var snapshotData = snapshot.data();
                    if (snapshotData is Map<String, dynamic>) {
                      int money = snapshotData['money'] + 100;

                      transaction.update(documentReference, {"money": money});
                    }
                  }
                });
              },
              
              child: Card(
                child: ListTile(
                   trailing: Text("\$${snapshot.data!.docs[i]['money']}"),
                  subtitle: Text("Age: ${snapshot.data!.docs[i]['age']}"),
                  title: Text(
                    "${snapshot.data!.docs[i]['name']}",
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
            );
          });
        }),
      )
    );
  }
}


// Container(
//         child: ListView.builder(
//           itemCount: data.length,
//           itemBuilder: (context, i) {
//             return InkWell(
//               onLongPress: (){
                
//               },
              
//               child: Card(
//                 child: ListTile(
//                   trailing: Text("\$${data[i]['money']}"),
//                   subtitle: Text("Age: ${data[i]['age']}"),
//                   title: Text(
//                     data[i]['name'],
//                     style: const TextStyle(fontSize: 30),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),



