import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Primeirp App',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Meu primeiro app'
          ),
        ),
        body: Center(
          child: Text(
            'Olá Mundo!'
          ),
        ),
      ),
    );
  }
}