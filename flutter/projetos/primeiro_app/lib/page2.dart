
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Contador de Cliques')
        ),
        body: Center(
          child:
          Contador(),
        ),
      ),
    );
  }
}

class Contador extends StatefulWidget{
  @override
  _ContadorState createState() => _ContadorState();
}

class _ContadorState extends State<Contador>{
  int contador = 0;

  void incrementar(){
    setState(() {
      contador++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Valor: $contador'),
        ElevatedButton(
          onPressed: incrementar, 
          child: Text('Incrementar')
        )
      ],
    );
  }
}