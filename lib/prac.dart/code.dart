import 'package:flutter/material.dart';
import 'package:flutter_course/prac.dart/practice.dart';

class codes extends StatefulWidget {
  const codes({super.key});

  @override
  State<codes> createState() => _codesState();
}

class _codesState extends State<codes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Saves"),
        ),
        body: Column(
          children: [
            customcards(
              name: "naser",
              lastname: "shadid",
              DOB: "23-11-2003",
              imagename: 'cybercat.jpg',
            ),
            MaterialButton(onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => practice()));
            }),
            Container(
              child: Text(
                "Naser",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class customcards extends StatelessWidget {
  final String name;
  final String lastname;
  final String DOB;
  final String imagename;

  const customcards(
      {super.key,
      required this.name,
      required this.lastname,
      required this.DOB,
      required this.imagename});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Card(
              child: Row(
            children: [
              Container(
                  height: 70,
                  width: 70,
                  child: Image.asset(
                    "images/$imagename",
                    fit: BoxFit.cover,
                  )),
              Expanded(
                child: ListTile(
                  title: Text("$name"),
                  subtitle: Text("$lastname"),
                  trailing: Text("$DOB"),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

// Post is for adding data, get is for getting the data
