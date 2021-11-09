import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VotoRoute extends StatefulWidget {

  final String sucoId;

  VotoRoute(this.sucoId);

  @override
  State<VotoRoute> createState() => _VotoRouteState();
}

class _VotoRouteState extends State<VotoRoute> {
  @override
  Widget build(BuildContext context) {

    FirebaseFirestore.instance
    .collection('sucos')
    .doc(widget.sucoId)
    .get()
    .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });

    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World: ${widget.sucoId}'),
          ),
        ),
      ),
    );
  }
}