


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:waiting_tickets_system/main.dart';

class TipoAtendimentoRoute extends StatefulWidget {
  @override
  _TipoAtendimentoRouteState createState() => _TipoAtendimentoRouteState();
}

enum TipoAtendimento { normal, preferencial }

class _TipoAtendimentoRouteState extends State<TipoAtendimentoRoute> {
  String _senhaPref = "";

  Future<Map> gerarSenha() async {
    String request = _tipoAtendimentoSelected == TipoAtendimento.normal
        ? Home.dominio + '/senha/createnormal'
        : Home.dominio + '/senha/createpref';

    http.Response _response = await http.post(request);
    Map<String, dynamic> map = json.decode(_response.body);

    return map;
  }

  TipoAtendimento _tipoAtendimentoSelected = TipoAtendimento.normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Gerenciador de senhas'), centerTitle: true),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("SELECIONE O TIPO DE ATENDIMENTO:",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0)),
              ListTile(
                  title: Text('Normal'),
                  leading: Radio(
                    value: TipoAtendimento.normal,
                    groupValue: _tipoAtendimentoSelected,
                    onChanged: (TipoAtendimento value) {
                      setState(() {
                        _tipoAtendimentoSelected = value;
                      });
                    },
                  )),
              ListTile(
                title: Text('Preferêncial'),
                leading: Radio(
                    value: TipoAtendimento.preferencial,
                    groupValue: _tipoAtendimentoSelected,
                    onChanged: (TipoAtendimento value) {
                      setState(() {
                        _tipoAtendimentoSelected = value;
                      });
                    }),
              ),
              RaisedButton(child:Text("GERAR") ,
                  onPressed: () async {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }));

                String desc;
                try {
                  Map map = await gerarSenha();
                  desc = map['descricao'];
                  print(desc);
                } catch (Exception) {
                  //Handle Exception
                } finally {
                  Navigator.pop(context);
                }
                Navigator.pop(context, desc);
              })
            ]));
  }
}
