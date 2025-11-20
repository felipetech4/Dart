import 'package:flutter/material.dart';
import '../modelos/movimentacao.dart';
import '../telas/tela_editar_movimentacao.dart';
import '../main.dart';

class ListaMovimentacoes extends StatelessWidget {
  final List<Movimentacao> movimentacoes;
  final String titulo;
  final Function(String)? aoMarcarPago;
  final VoidCallback? aoAtualizar;

  const ListaMovimentacoes({
    super.key,
    required this.movimentacoes,
    required this.titulo,
    this.aoMarcarPago,
    this.aoAtualizar,
  });

  @override
  Widget build(BuildContext context) {
    if (movimentacoes.isEmpty) return const SizedBox.shrink();

    final cor = titulo.contains('Despesas') ? Colors.red.shade600 : Colors.green.shade600;
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning, color: cor),
                const SizedBox(width: 8),
                Text(
                  titulo,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: cor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${movimentacoes.length}',
                    style: TextStyle(
                      color: cor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...movimentacoes.map(_buildItem),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(Movimentacao mov) {
    final corFundo = mov.estaVencido ? Colors.red.shade50 : 
                     mov.proximoAoVencimento ? Colors.orange.shade50 : Colors.grey.shade50;
    final corBorda = mov.estaVencido ? Colors.red.shade200 : 
                     mov.proximoAoVencimento ? Colors.orange.shade200 : Colors.grey.shade200;
    final corValor = mov.tipo == TipoMovimentacao.receita ? Colors.green.shade700 : Colors.red.shade700;
    
    return GestureDetector(
      onTap: () => _mostrarModalOpcoes(mov),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: corFundo,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: corBorda),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mov.descricaoCompleta,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Vencimento: ${_formatarData(mov.dataVencimento)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  if (mov.diasParaVencimento <= 1 && !mov.estaPago)
                    Text(
                      _getTextoVencimento(mov),
                      style: TextStyle(
                        fontSize: 11,
                        color: mov.estaVencido ? Colors.red.shade700 : Colors.orange.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
            Text(
              'R\$ ${mov.valor.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: corValor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarModalOpcoes(Movimentacao mov) {
    showModalBottomSheet(
      context: navigatorKey.currentContext!,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar'),
              onTap: () async {
                Navigator.pop(context);
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaEditarMovimentacao(movimentacao: mov),
                  ),
                );
                if (resultado == true && aoAtualizar != null) aoAtualizar!();
              },
            ),
            if (!mov.estaPago && aoMarcarPago != null)
              ListTile(
                leading: const Icon(Icons.check),
                title: const Text('Marcar como pago'),
                onTap: () {
                  Navigator.pop(context);
                  aoMarcarPago!(mov.id);
                },
              ),
          ],
        ),
      ),
    );
  }

  String _getTextoVencimento(Movimentacao mov) {
    if (mov.diasParaVencimento < 0) return 'VENCIDO!';
    if (mov.diasParaVencimento == 0) return 'Vence hoje!';
    if (mov.diasParaVencimento == 1) return 'Vence amanhã!';
    return '';
  }

  String _formatarData(DateTime data) =>
      '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
}