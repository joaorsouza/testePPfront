import 'package:flutter/material.dart';
import 'package:waiting_tickets_system/OpcoesGerenteRoute.dart';
import 'TipoAtendimentoRoute.dart';

class OpcoesUsuarioRoute extends StatefulWidget {
  @override
  _OpcoesUsuarioRouteState createState() => _OpcoesUsuarioRouteState();
}

class _OpcoesUsuarioRouteState extends State<OpcoesUsuarioRoute> {
  String textFieldAviso = 'Toque no botão para gerar uma senha!';

  String senhaAtual = '';

  String senhaGerada = '';

  //var _isBtnPressed = false;

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
                            Text("SENHA ATUAL:",
                                style: TextStyle(fontSize: 25.0)),
                            Text('$senhaAtual',
                                style: TextStyle(
                                    fontSize: senhaAtual.contains('S')
                                        ? 40.0
                                        : 80.0)),
                            RaisedButton(child: Text('Acompanhar senha'),onPressed: (){
                            setState(() {
                              senhaAtual = OpcoesGerenteRouteState.senhaAtual;
                            });
                            })
                          ],
                        ))),
                Flexible(
                    child: Container(
                  padding: EdgeInsets.only(top: 40.0, bottom: 30.0),
                  child: Column(children: [
                    Flexible(
                        child: Container(
                            child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Sua senha:", style: TextStyle(fontSize: 20.0)),
                        Text(
                          "$senhaGerada",
                          style: TextStyle(fontSize: 60.0),
                        )
                      ],
                    ))),
                    Flexible(
                        child: Container(
                            child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "$textFieldAviso",
                          style: TextStyle(fontSize: 17.0),
                        ),
                        RaisedButton(
                            onPressed: () async {
                              String result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TipoAtendimentoRoute()),
                              );

                              if (result != null) {
                                Scaffold.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(SnackBar(
                                      content: Text(
                                          'Senha Gerada! Aguarde Atendimento.')));
                                setState(() {
                                  textFieldAviso =
                                      'Senha gerada! Aguarde atendimento.';
                                  senhaGerada = result;
                                });
                              }
                            },
                            child: Text("GERAR SENHA"))
                      ],
                    ))),
                  ]),
                ))
              ]);
        }));
  }
}
