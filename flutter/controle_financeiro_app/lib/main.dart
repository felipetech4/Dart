//Escopo da tela inicial finalizado. Pendente criar modal para adicionar nova transação.

import 'package:flutter/material.dart';

void main() {
  runApp(const ControleFinanceiroApp());
}

class ControleFinanceiroApp extends StatelessWidget {
  const ControleFinanceiroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle Financeiro',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: const TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> despesas = [
      {'titulo': 'Supermercado', 'valor': 120.50, 'data': '06/07/2025'},
      {'titulo': 'Internet', 'valor': 89.90, 'data': '05/07/2025'},
      {'titulo': 'Gasolina', 'valor': 150.00, 'data': '03/07/2025'}
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Despesas'),
      ),
      body: ListView.builder(
        itemCount: despesas.length,
        itemBuilder: (context, index){
          final item = despesas[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.money_outlined),
              title: Text(item['titulo']),
              subtitle: Text('Data: ${item['data']}'),
              trailing: Text(
                'R\$ ${item['valor'].toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //Implementar funcionalidade para adicionar nova despesa
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Botão pressionado!')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
