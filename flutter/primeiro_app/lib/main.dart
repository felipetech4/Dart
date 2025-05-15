import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App_Simples',
      home: Scaffold(
        appBar: AppBar(title: Text('Tela Principal')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, color: Colors.red, size: 80),
              SizedBox(height: 20),
              Text('Você curtiu isso!', style: TextStyle(fontSize: 24)),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print('Clicou!');
                    },
                    child: Text('Clicar'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      print('Compartilhou');
                    },
                    child: Text('Compartilhar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
