enum TipoMovimentacao { despesa, receita }
enum StatusMovimentacao { pendente, pago }

class Movimentacao {
  final String id;
  final String descricao;
  final double valor;
  final DateTime dataVencimento;
  final TipoMovimentacao tipo;
  final StatusMovimentacao status;
  final DateTime? dataPagamento;
  final bool isFixa;
  final int? totalParcelas;
  final int? parcelaAtual;
  final String? idGrupo;

  const Movimentacao({
    required this.id,
    required this.descricao,
    required this.valor,
    required this.dataVencimento,
    required this.tipo,
    required this.status,
    this.dataPagamento,
    this.isFixa = false,
    this.totalParcelas,
    this.parcelaAtual,
    this.idGrupo,
  });

  bool get estaPago => status == StatusMovimentacao.pago;

  int get diasParaVencimento {
    final hoje = DateTime.now();
    final diferenca = dataVencimento.difference(DateTime(hoje.year, hoje.month, hoje.day));
    return diferenca.inDays;
  }

  bool get proximoAoVencimento => diasParaVencimento <= 1;
  bool get estaVencido => diasParaVencimento < 0;

  Movimentacao marcarComoPago() => Movimentacao(
    id: id,
    descricao: descricao,
    valor: valor,
    dataVencimento: dataVencimento,
    tipo: tipo,
    status: StatusMovimentacao.pago,
    dataPagamento: DateTime.now(),
    isFixa: isFixa,
    totalParcelas: totalParcelas,
    parcelaAtual: parcelaAtual,
    idGrupo: idGrupo,
  );

  String get descricaoCompleta => totalParcelas != null && parcelaAtual != null
      ? '$descricao ($parcelaAtual/$totalParcelas)'
      : descricao;
}