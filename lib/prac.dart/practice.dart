import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class practice extends StatefulWidget {
  const practice({super.key});

  @override
  State<practice> createState() => _practiceState();
}

List data = [];
bool loading = true;

class _practiceState extends State<practice> {
  Future<List> getData() async {
    var response =
        await get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    List responsebody = jsonDecode(response.body);
    return responsebody;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Revision Time"),
            ),
            body: Container(child: Text("Practice Page"),)));
  }
}

  // Future<List> getData() async {
  //   var response =
  //       await get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
  //   List responsebody = jsonDecode(response.body);
  //   return responsebody;
  // }

// FutureBuilder<List>(
//               future: getData(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 if (snapshot.hasData) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     return ListView.builder(
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                             child: Row(children: [
//                           Container(
//                               height: 70,
//                               width: 70,
//                               child: Image.asset(
//                                 "images/Imglogo.png",
//                                 fit: BoxFit.cover,
//                               )),
//                           Expanded(
//                             child: ListTile(
//                               title: Text(
//                                   "title: ${snapshot.data![index]["title"]}"),
//                               subtitle: Text(
//                                   "subtitle: ${snapshot.data![index]["id"]}"),
//                             ),
//                           ),
//                         ]));
//                       },
//                     );
//                   }
//                 }
//                 if (snapshot.hasError) {
//                   return Text("Error");
//                 }

//                 return Text("Empty");
//               },
//             )