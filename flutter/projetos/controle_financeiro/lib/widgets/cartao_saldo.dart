import 'package:flutter/material.dart';
import '../modelos/resumo_financeiro.dart';

class CartaoSaldo extends StatelessWidget {
  final ResumoFinanceiro resumo;

  const CartaoSaldo({super.key, required this.resumo});

  @override
  Widget build(BuildContext context) {
    final isPositive = resumo.limiteDisponivel >= resumo.saldoAtual;
    final trendColor = isPositive ? Colors.green.shade200 : Colors.red.shade200;

    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.blue.shade600, Colors.blue.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Saldo Atual',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'R\$ ${resumo.saldoAtual.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Limite Disponível',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    Text(
                      'R\$ ${resumo.limiteDisponivel.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: trendColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Icon(
                  isPositive ? Icons.trending_up : Icons.trending_down,
                  color: trendColor,
                  size: 32,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
