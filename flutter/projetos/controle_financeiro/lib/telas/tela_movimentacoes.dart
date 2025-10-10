import 'package:flutter/material.dart';
import '../modelos/movimentacao.dart';
import '../servicos/servico_financeiro.dart';

class TelaMovimentacoes extends StatefulWidget {
  final DateTime mesAtual;
  const TelaMovimentacoes({super.key, required this.mesAtual});

  @override
  State<TelaMovimentacoes> createState() => _TelaMovimentacoesState();
}

class _TelaMovimentacoesState extends State<TelaMovimentacoes> {
  final _servico = ServicoFinanceiro();

  List<Movimentacao> _ordenar(List<Movimentacao> lista) {
    lista.sort((a, b) {
      if (a.estaPago != b.estaPago) return a.estaPago ? 1 : -1;
      return a.dataVencimento.compareTo(b.dataVencimento);
    });
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    final movimentacoes = _servico.obterMovimentacoesMes(widget.mesAtual);
    final despesas = _ordenar(movimentacoes.where((m) => m.tipo == TipoMovimentacao.despesa).toList());
    final receitas = _ordenar(movimentacoes.where((m) => m.tipo == TipoMovimentacao.receita).toList());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movimentações'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Row(
        children: [
          _buildColuna('Despesas', despesas, Colors.red),
          const VerticalDivider(width: 1),
          _buildColuna('Receitas', receitas, Colors.green),
        ],
      ),
    );
  }

  Widget _buildColuna(String titulo, List<Movimentacao> lista, MaterialColor cor) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: cor.shade50,
            child: Text(
              '$titulo (${lista.length})',
              style: TextStyle(
                color: cor.shade700,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) => _buildItem(lista[index], cor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(Movimentacao mov, MaterialColor cor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: !mov.estaPago ? () => setState(() => _servico.marcarComoPago(mov.id)) : null,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: mov.estaPago ? Colors.teal : cor,
              child: Text(
                mov.estaPago ? 'PAGO' : 'PAGAR',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mov.descricaoCompleta,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  'R\$ ${mov.valor.toStringAsFixed(2).replaceAll('.', ',')}',
                  style: TextStyle(
                    fontSize: 14,
                    color: cor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}