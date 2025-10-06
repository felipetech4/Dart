import 'package:controle_financeiro_app/modelos/transacao.dart';

class CalculosFinanceiros {
  static double calcularSaldoAtual(List<Transacao> transacoes) {
    final receitasRecebidas = transacoes
      .where((t) => t.tipo == 'receita' && t.statusPago)
      .fold(0.0, (total, t) => total + t.valor);

    final despesasPagas = transacoes
      .where((t) => t.tipo == 'despesa' && t.statusPago)
      .fold(0.0, (total, t) => total + t.valor);

    return receitasRecebidas - despesasPagas;
  }

  static double calcularSaldoMensalProjetado(List<Transacao> transacoes) {
    final agora = DateTime.now();
    final mesAtual = agora.month;
    final anoAtual = agora.year;

    final receitasMesAtual = transacoes.where((t) =>
      t.tipo == 'receita' &&
      t.data.month == mesAtual &&
      t.data.year == anoAtual
    );

    final despesasMesAtual = transacoes.where((t) =>
      t.tipo == 'despesa' &&
      t.data.month == mesAtual &&
      t.data.year == anoAtual
    );

    final receitasPendentesAnteriores = transacoes.where((t) =>
      t.tipo == 'receita' &&
      !t.statusPago &&
      (t.data.isBefore(DateTime(anoAtual, mesAtual, 1)))
    );

    final despesasPendentesAnteriores = transacoes.where((t) =>
      t.tipo == 'despesa' &&
      !t.statusPago &&
      (t.data.isBefore(DateTime(anoAtual, mesAtual, 1)))
    );

    final totalReceitas = [...receitasMesAtual, ...receitasPendentesAnteriores]
        .fold(0.0, (total, t) => total + t.valor);

    final totalDespesas = [...despesasMesAtual, ...despesasPendentesAnteriores]
        .fold(0.0, (total, t) => total + t.valor);

    return totalReceitas - totalDespesas;
  }

  static double calcularReceitasAReceber(List<Transacao> transacoes) {
    final hoje = DateTime.now();
    final fimDoMes = DateTime(hoje.year, hoje.month + 1, 0);

    return transacoes
        .where((t) =>
          t.tipo == 'receita' &&
          !t.statusPago &&
          t.data.isBefore(fimDoMes.add(const Duration(days: 1)))
        )
        .fold(0.0, (total, t) => total + t.valor);
  }

  static double calcularDespesasAPagar(List<Transacao> transacoes) {
    final hoje = DateTime.now();
    final fimDoMes = DateTime(hoje.year, hoje.month + 1, 0);

    return transacoes
        .where((t) =>
          t.tipo == 'despesa' &&
          !t.statusPago &&
          t.data.isBefore(fimDoMes.add(const Duration(days: 1)))
        )
        .fold(0.0, (total, t) => total + t.valor);
  }

  static bool estaVencida(DateTime data) {
    final hoje = DateTime.now();
    final dataHoje = DateTime(hoje.year, hoje.month, hoje.day);
    final dataAlvo = DateTime(data.year, data.month, data.day);
    return dataAlvo.isBefore(dataHoje);
  }

  static bool venceEmTresDiasOuMenos(DateTime data) {
    final hoje = DateTime.now();
    final dataHoje = DateTime(hoje.year, hoje.month, hoje.day);
    final dataAlvo = DateTime(data.year, data.month, data.day);

    final diferenca = dataAlvo.difference(dataHoje).inDays;
    return diferenca >= 0 && diferenca <= 3;
  }
}
