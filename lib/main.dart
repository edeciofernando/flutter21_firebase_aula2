import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//void main() => runApp(MyApp());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: _body(context),
        floatingActionButton: FloatingActionButton(
//          onPressed: adicionar,
          onPressed: () {},
          tooltip: 'Adicionar Suco',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  CollectionReference cfSucos = FirebaseFirestore.instance.collection("sucos");

  // Future<void> adicionar() async {
  //   await Firebase.initializeApp();

  //   cfSucos.add({
  //     "fruta": "Abacaxi",
  //     "marca": "Del Valle",
  //     "preco": 6.50,
  //     "foto": "https://assets.instabuy.com.br/ib.item.image.big/b-1812a420e5f5457e89de8903170bd2a9.jpeg"
  //   });
  // }

  Column _body(context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: cfSucos.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final data = snapshot.requireData;

              return ListView.builder(
                itemCount: data.size,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        data.docs[index].get("foto"),
                      ),
                    ),
                    title: Text(data.docs[index].get("fruta")),
                    subtitle: Text(data.docs[index].get("marca") +
                        "\n" +
                        NumberFormat.simpleCurrency(locale: "pt_BR")
                            .format(data.docs[index].get("preco"))),
                    isThreeLine: true,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
