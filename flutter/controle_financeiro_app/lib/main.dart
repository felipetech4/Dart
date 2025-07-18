//Pendente. Adicionar categorias.

import 'package:controle_financeiro_app/modelos/transacao.dart';
import 'package:controle_financeiro_app/componentes/formulario_transacao.dart';
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

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial>{
  final List<Transacao> _transacoes = [
    Transacao(titulo: 'Supermercado', valor: 120.50, data: DateTime(2025, 7, 6), tipo: 'despesa', categoria: 'Alimentacao', statusPago: true), 
    Transacao(titulo: 'Salário', valor: 3500.00, data: DateTime(2025, 7, 5), tipo: 'receita', categoria: 'Salario', statusPago: true),       
  ];

  //Abre o modal de cadastro
  void _abrirFormTransacao(){
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true, 
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          //Empurra pra cima quando o teclado aparece
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
          child: FormularioTransacao(salvarForm: _adicionarTransacao),
      )
    );
  }

  //Adiciona nova transacao e fecha o modal
  void _adicionarTransacao(Transacao nova){
    setState(() => _transacoes.add(nova));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Transações'),
      ),
      body: ListView.builder(
        itemCount: _transacoes.length,
        itemBuilder: (ctx, i){
          final t = _transacoes[i];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: Icon(
                t.tipo == 'despesa' ? Icons.arrow_downward : Icons.arrow_upward,
                color: t.statusPago ?
                (
                  t.tipo == 'despesa' ?
                  Colors.red : Colors.green
                ) : Colors.grey
              ),
              title: Text(t.titulo), 
              subtitle:
              Text(
                '${t.data.day}/${t.data.month}/${t.data.year} · ${t.categoria}\n''Status: ${t.statusPago ? "Pago" : "Pendente"}'
              ),
              trailing: Text(
                'R\$ ${t.valor.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirFormTransacao,
        child: const Icon(Icons.add),
      ),
    );
  }
}