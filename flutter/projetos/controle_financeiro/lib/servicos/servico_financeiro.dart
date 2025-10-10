import '../modelos/movimentacao.dart';
import '../modelos/resumo_financeiro.dart';

class ServicoFinanceiro {
  static final ServicoFinanceiro _instancia = ServicoFinanceiro._interno();
  factory ServicoFinanceiro() => _instancia;
  ServicoFinanceiro._interno();

  final List<Movimentacao> _movimentacoes = [];
  static const double _saldoInicial = 0.0;

  void inicializarDadosMock() {
    _movimentacoes.clear();
    _gerarDadosMock();
  }

  void _gerarDadosMock() {
    final hoje = DateTime.now();
    _movimentacoes.addAll([
      _criarDespesa('1', 'Conta de Luz', 180.50, DateTime(hoje.year, hoje.month, 2)),
      _criarDespesa('2', 'Internet', 89.90, hoje),
      _criarDespesa('3', 'Cartão de Crédito', 450.00, DateTime(hoje.year, hoje.month, 27)),
      _criarDespesaPaga('4', 'Aluguel', 1200.00, DateTime(hoje.year, hoje.month, 1)),
      _criarDespesa('5', 'Supermercado', 320.75, DateTime(hoje.year, hoje.month, 1)),
      _criarReceitaPaga('6', 'Salário', 4500.00, DateTime(hoje.year, hoje.month, 5)),
      _criarReceita('7', 'Freelance', 800.00, DateTime(hoje.year, hoje.month, 1)),
      _criarReceita('8', 'Extra', 1000.00, DateTime(hoje.year, hoje.month, 2)),
    ]);
  }

  Movimentacao _criarDespesa(String id, String descricao, double valor, DateTime data) =>
      Movimentacao(
        id: id,
        descricao: descricao,
        valor: valor,
        dataVencimento: data,
        tipo: TipoMovimentacao.despesa,
        status: StatusMovimentacao.pendente,
      );

  Movimentacao _criarDespesaPaga(String id, String descricao, double valor, DateTime data) =>
      Movimentacao(
        id: id,
        descricao: descricao,
        valor: valor,
        dataVencimento: data,
        tipo: TipoMovimentacao.despesa,
        status: StatusMovimentacao.pago,
        dataPagamento: data,
      );

  Movimentacao _criarReceita(String id, String descricao, double valor, DateTime data) =>
      Movimentacao(
        id: id,
        descricao: descricao,
        valor: valor,
        dataVencimento: data,
        tipo: TipoMovimentacao.receita,
        status: StatusMovimentacao.pendente,
      );

  Movimentacao _criarReceitaPaga(String id, String descricao, double valor, DateTime data) =>
      Movimentacao(
        id: id,
        descricao: descricao,
        valor: valor,
        dataVencimento: data,
        tipo: TipoMovimentacao.receita,
        status: StatusMovimentacao.pago,
        dataPagamento: data,
      );

  List<Movimentacao> obterMovimentacoesMes(DateTime mes) =>
      _movimentacoes.where((mov) => 
          mov.dataVencimento.year == mes.year && 
          mov.dataVencimento.month == mes.month).toList();

  List<Movimentacao> _obterMovimentacoesPrioritarias(DateTime mes, TipoMovimentacao tipo) {
    final movimentacoes = obterMovimentacoesMes(mes)
        .where((mov) => mov.tipo == tipo && mov.proximoAoVencimento && !mov.estaPago)
        .toList();
    movimentacoes.sort((a, b) => a.dataVencimento.compareTo(b.dataVencimento));
    return movimentacoes;
  }

  List<Movimentacao> obterDespesasPrioritarias(DateTime mes) =>
      _obterMovimentacoesPrioritarias(mes, TipoMovimentacao.despesa);

  List<Movimentacao> obterReceitasPrioritarias(DateTime mes) =>
      _obterMovimentacoesPrioritarias(mes, TipoMovimentacao.receita);

  ResumoFinanceiro obterResumoFinanceiro(DateTime mes) {
    final movimentacoes = obterMovimentacoesMes(mes);
    
    final despesasPagas = _calcularTotal(movimentacoes, TipoMovimentacao.despesa, true);
    final receitasRecebidas = _calcularTotal(movimentacoes, TipoMovimentacao.receita, true);
    final despesasPendentes = _calcularTotal(movimentacoes, TipoMovimentacao.despesa, false);
    final receitasPendentes = _calcularTotal(movimentacoes, TipoMovimentacao.receita, false);
    final totalDespesas = despesasPagas + despesasPendentes;
    final totalReceitas = receitasRecebidas + receitasPendentes;

    return ResumoFinanceiro(
      saldoAtual: _saldoInicial + receitasRecebidas - despesasPagas,
      restanteAPagar: despesasPendentes,
      restanteAReceber: receitasPendentes,
      totalDespesasMes: totalDespesas,
      totalReceitasMes: totalReceitas,
    );
  }

  double _calcularTotal(List<Movimentacao> movimentacoes, TipoMovimentacao tipo, bool pago) =>
      movimentacoes
          .where((mov) => mov.tipo == tipo && mov.estaPago == pago)
          .fold(0.0, (sum, mov) => sum + mov.valor);

  void marcarComoPago(String id) {
    final index = _movimentacoes.indexWhere((mov) => mov.id == id);
    if (index != -1) {
      _movimentacoes[index] = _movimentacoes[index].marcarComoPago();
    }
  }

  void adicionarMovimentacao(Movimentacao movimentacao) =>
      _movimentacoes.add(movimentacao);
}