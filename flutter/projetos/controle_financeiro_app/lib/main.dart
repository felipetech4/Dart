import 'package:flutter/material.dart';
import 'package:controle_financeiro_app/modelos/transacao.dart';
import 'package:controle_financeiro_app/componentes/formulario_transacao.dart';
import 'package:controle_financeiro_app/utils/calculos.dart';

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
        primarySwatch: Colors.green,
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

class _TelaInicialState extends State<TelaInicial> {
  final List<Transacao> _transacoes = [
    Transacao(
      titulo: 'Salário',
      valor: 3500.00,
      data: DateTime(2025, 7, 5),
      tipo: 'receita',
      categoria: 'Salário',
      statusPago: true,
    ),
    Transacao(
      titulo: 'Supermercado',
      valor: 200.00,
      data: DateTime(2025, 7, 10),
      tipo: 'despesa',
      categoria: 'Alimentação',
      statusPago: true,
    ),
    Transacao(
      titulo: 'Conta de Luz',
      valor: 150.00,
      data: DateTime(2025, 7, 20),
      tipo: 'despesa',
      categoria: 'Contas',
      statusPago: false,
    ),
    Transacao(
      titulo: 'Freelancer',
      valor: 500.00,
      data: DateTime(2025, 7, 25),
      tipo: 'receita',
      categoria: 'Extra',
      statusPago: false,
    ),
  ];

  void _abrirFormTransacao() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: FormularioTransacao(salvarForm: _adicionarTransacao),
      ),
    );
  }

  void _adicionarTransacao(Transacao nova) {
    setState(() => _transacoes.add(nova));
    Navigator.of(context).pop();
  }

  Widget _construirCard(String titulo, String valor, Color cor) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(Icons.attach_money, color: cor, size: 32),
        title: Text(titulo),
        subtitle: Text(
          valor,
          style: TextStyle(
            color: cor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _construirCardInterativo(
    BuildContext context,
    String titulo,
    String valor,
    Color cor,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(Icons.info_outline, color: cor, size: 32),
        title: Text(titulo),
        subtitle: Text(
          valor,
          style: TextStyle(
            color: cor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final saldoAtual = CalculosFinanceiros.calcularSaldoAtual(_transacoes);
    final saldoProjetado = CalculosFinanceiros.calcularSaldoMensalProjetado(_transacoes);
    final receitasPendentes = CalculosFinanceiros.calcularReceitasAReceber(_transacoes);
    final despesasPendentes = CalculosFinanceiros.calcularDespesasAPagar(_transacoes);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle Mensal'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Gerenciar Categorias'),
              onTap: () {
                // Criar tela de categorias
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Relatório Mensal'),
              onTap: () {
                // Criar tela de relatório
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: () {
                // Criar funcionalidade de logout
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _construirCard('Saldo Atual', 'R\$ ${saldoAtual.toStringAsFixed(2)}', Colors.green),
            _construirCard(
                'Saldo Mensal Projetado', 'R\$ ${saldoProjetado.toStringAsFixed(2)}', Colors.blue),
            _construirCardInterativo(
              context,
              'Receitas a Receber',
              'R\$ ${receitasPendentes.toStringAsFixed(2)}',
              Colors.orange,
              () {
                // Criar tela de receitas
              },
            ),
            _construirCardInterativo(
              context,
              'Despesas a Pagar',
              'R\$ ${despesasPendentes.toStringAsFixed(2)}',
              Colors.red,
              () {
                // Criar tela de despesas
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirFormTransacao,
        tooltip: 'Adicionar Transação',
        child: const Icon(Icons.add),
      ),
    );
  }
}
