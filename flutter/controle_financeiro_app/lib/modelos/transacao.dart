class Transacao{
  final String titulo;
  final double valor;
  final DateTime data;
  final String tipo; //Despesa ou Receita
  final bool statusPago;
  final String categoria;

  Transacao({
    required this.titulo,
    required this.valor,
    required this.data,
    required this.tipo,
    required this.categoria,
    this.statusPago = false
  });
}