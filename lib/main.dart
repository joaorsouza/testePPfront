import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'OpcoesGerenteRoute.dart';
import 'OpcoesUsuarioRoute.dart';
import 'package:http/http.dart' as http;


import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  static String dominio;
  static String token;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: "127.0.0.1:8080");
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
        appBar: AppBar(title: Text('Gerenciador de senhas'), centerTitle: true),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsetsDirectional.only(bottom: 25.0),
                child: Text(
                  'ESCOLHA UM MODO:',
                  style: TextStyle(fontSize: 25.0),
                )),
            RaisedButton(
                child: Text('MODO GERENTE'),
                onPressed: () async {
                  Home.dominio = 'http://' + controller.text + '/testePP/rest';
                  try {
                    Response response = await http.post(
                        Home.dominio + "/login/logar");
                    Map<String, String> map = response.headers;
                    Home.token = map['authorization'];
                    print(Home.token);
                  }catch(e){
                    print(e.toString());
                  }



                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OpcoesGerenteRoute()),
                  );
                }),
            RaisedButton(
                child: Text('MODO USUÁRIO'),
                onPressed: () {
                  Home.dominio = 'http://' + controller.text  + '/testePP/rest';
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OpcoesUsuarioRoute()),
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'IP e porta do Dominio da aplicação',
                ),
              ),
            )
          ],
        )));
  }
}

class Orientacao {
  Orientacao() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}
