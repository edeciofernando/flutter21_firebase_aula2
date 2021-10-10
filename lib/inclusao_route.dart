import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InclusaoRoute extends StatefulWidget {
  const InclusaoRoute({Key? key}) : super(key: key);

  @override
  _InclusaoRouteState createState() => _InclusaoRouteState();
}

class _InclusaoRouteState extends State<InclusaoRoute> {
  var _edFruta = TextEditingController();
  var _edMarca = TextEditingController();
  var _edPreco = TextEditingController();
  var _edFoto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inclusão de Sucos'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Voltar',
        child: const Icon(Icons.arrow_back),
      ),
    );
  }

  Container _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _edFruta,
            keyboardType: TextInputType.name,
            style: TextStyle(
              fontSize: 20,
            ),
            decoration: InputDecoration(
              labelText: "Fruta",
            ),
          ),
          TextFormField(
            controller: _edMarca,
            keyboardType: TextInputType.name,
            style: TextStyle(
              fontSize: 20,
            ),
            decoration: InputDecoration(
              labelText: "Marca",
            ),
          ),
          TextFormField(
            controller: _edPreco,
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 20,
            ),
            decoration: InputDecoration(
              labelText: "Preço R\$",
            ),
          ),
          TextFormField(
            controller: _edFoto,
            keyboardType: TextInputType.url,
            style: TextStyle(
              fontSize: 20,
            ),
            decoration: InputDecoration(
              labelText: "URL da Foto",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ElevatedButton(
              onPressed: _gravaDados,
              child: Text("Cadastrar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _gravaDados() async {
    if (_edFruta.text == "" ||
        _edMarca.text == "" ||
        _edPreco.text == "" ||
        _edFoto.text == "") {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Atenção'),
              content: Text('Por favor, preencha todos os dados'),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok')),
              ],
            );
          }
      );
      return;    
    }

    CollectionReference cfSucos = FirebaseFirestore.instance.collection("sucos");
  
    await cfSucos.add({
      "fruta": _edFruta.text,
      "marca": _edMarca.text,
      "preco": double.parse(_edPreco.text),
      "foto": _edFoto.text
    });

    showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Cadastrado Concluído!'),
              content: Text('Suco de ${_edFruta.text} foi inserido na base de dados'),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok')),
              ],
            );
          }
      );

    _edFruta.text = "";
    _edMarca.text = "";
    _edPreco.text = "";
    _edFoto.text = "";
  }
}
