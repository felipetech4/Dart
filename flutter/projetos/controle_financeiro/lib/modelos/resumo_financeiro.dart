class ResumoFinanceiro {
  final double saldoAtual;
  final double restanteAPagar;
  final double restanteAReceber;
  final double totalDespesasMes;
  final double totalReceitasMes;

  const ResumoFinanceiro({
    required this.saldoAtual,
    required this.restanteAPagar,
    required this.restanteAReceber,
    required this.totalDespesasMes,
    required this.totalReceitasMes,
  });

  double get limiteDisponivel => saldoAtual + restanteAReceber - restanteAPagar;
}
