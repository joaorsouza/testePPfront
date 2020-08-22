import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:waiting_tickets_system/main.dart';

class OpcoesGerenteRoute extends StatefulWidget {
  @override
  OpcoesGerenteRouteState createState() => OpcoesGerenteRouteState();
}

class OpcoesGerenteRouteState extends State<OpcoesGerenteRoute> {
  static String senhaAtual = '';
  static String _senhaChamada = '';

  void reiniciarSenha() async {
    String request = Home.dominio + '/senha/reiniciar';

    await http.delete(request,headers: { HttpHeaders.authorizationHeader: Home.token});
  }

  Future<Map> chamarSenha() async {
    String request = Home.dominio + '/senha/chamar';

    http.Response _response = await http.delete(request, headers: {
      HttpHeaders.authorizationHeader: Home.token,
    });
    Map<String, dynamic> map = json.decode(_response.body);
    _senhaChamada = map['descricao'];
    if (_senhaChamada == null) {
      _senhaChamada = 'Sem senhas!';
    }
    senhaAtual = _senhaChamada;
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Gerenciador de senhas'), centerTitle: true),
        body: Builder(builder: (BuildContext context) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                    child: Container(
                        color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("SENHA CHAMADA:",
                                style: TextStyle(fontSize: 25.0)),
                            Text("$_senhaChamada",
                                style: TextStyle(
                                    fontSize: _senhaChamada.contains('S')
                                        ? 40.0
                                        : 80.0))
                          ],
                        ))),
                Flexible(
                    child: Container(
                        child: Center(
                            child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsetsDirectional.only(bottom: 25.0),
                        child: Text(
                          'ESCOLHA UMA OPÇÃO:',
                          style: TextStyle(fontSize: 25.0),
                        )),
                    RaisedButton(
                        child: Text(' CHAMAR SENHA   '),
                        onPressed: () async {
                          Map map = await chamarSenha();
                          setState(() {
                            if (_senhaChamada != null) {
                              Scaffold.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                  content: Text('Senha chamada!'),
                                ));
                            } else {
                              Scaffold.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                  content: Text('Sem senha para chamar!'),
                                ));
                            }
                          });
                        }),
                    RaisedButton(
                        child: Text('REINICIAR SENHAS'),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (a) => AlertDialog(
                                    title: Text("Atenção!"),
                                    content: Text(
                                        "As senhas serão apagadas. Tem certeza?"),
                                    actions: [
                                      FlatButton(
                                          child: Text("SIM"),
                                          onPressed: () {
                                            reiniciarSenha();
                                            Navigator.pop(context);
                                            setState(() {
                                              Scaffold.of(context)
                                                ..hideCurrentSnackBar()
                                                ..showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Senhas reiniciadas!'),
                                                ));
                                            });
                                          }),
                                      FlatButton(
                                          child: Text("NÃO"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          })
                                    ],
                                  ));
                        }),
                  ],
                ))))
              ]);
        }));
  }
}
