import 'package:flutter/material.dart';
import 'TipoAtendimentoRoute.dart';

import 'package:flutter/services.dart' ;

class OpcoesUsuarioRoute1 extends StatefulWidget {
  @override
  _OpcoesUsuarioRouteState1 createState() => _OpcoesUsuarioRouteState1();
}

class _OpcoesUsuarioRouteState1 extends State<OpcoesUsuarioRoute1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciador de Senhas'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.blue,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      color: Colors.blue,



                    ),

                    Expanded(
                      child: Container(
                        color: Colors.amber,


                      ),
                    ),
                  ],
                )


            ),
          ),

          Expanded(
            child: Container(
              color: Colors.amber,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.blue,



                  ),
                ),


              ],
            ),

            ),
          ),
        ],
      ),
    );
  }
}
