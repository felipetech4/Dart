import 'package:flutter/material.dart';
import '../modelos/resumo_financeiro.dart';

class CartaoResumo extends StatelessWidget {
  final ResumoFinanceiro resumo;

  const CartaoResumo({super.key, required this.resumo});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumo do Mês',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildItem('Restante a Pagar', resumo.restanteAPagar, Colors.red.shade600),
            _buildItem('Restante a Receber', resumo.restanteAReceber, Colors.green.shade600),
            const Divider(height: 24),
            _buildItem('Total Despesas', resumo.totalDespesasMes, Colors.red.shade400),
            _buildItem('Total Receitas', resumo.totalReceitasMes, Colors.green.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String titulo, double valor, Color cor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(titulo, style: const TextStyle(fontSize: 14)),
          Text(
            'R\$ ${valor.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: cor,
            ),
          ),
        ],
      ),
    );
  }
}