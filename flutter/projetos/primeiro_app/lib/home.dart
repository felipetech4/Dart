import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navegação Flutter',
      home: TelaHome(),
    );
  }
}

class TelaHome extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Home'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(
            'Ir para detalhes'
          ), onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TelaDetalhes(),
              )
            );
          }
        ) 
      ),
    );
  }
}

class TelaDetalhes extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Detalhes'),
      ),
      body: Center(
        child: ElevatedButton(child: Text(
          'Voltar'
          ), 
          onPressed: (){
            Navigator.pop(context);
          }
        )
      ),
    );
  }
}