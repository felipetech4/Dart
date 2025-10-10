import 'package:flutter/material.dart';
import '../servicos/servico_financeiro.dart';
import '../modelos/resumo_financeiro.dart';
import '../modelos/movimentacao.dart';
import '../widgets/cartao_saldo.dart';
import '../widgets/cartao_resumo.dart';
import '../widgets/lista_movimentacoes.dart';
import 'tela_movimentacoes.dart';
import 'tela_adicionar_movimentacao.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final _servico = ServicoFinanceiro();
  late ResumoFinanceiro _resumo;
  late List<Movimentacao> _despesasPrioritarias;
  late List<Movimentacao> _receitasPrioritarias;
  late PageController _pageController;
  DateTime _mesAtual = DateTime.now();
  static const int _paginaInicial = 1000;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _paginaInicial);
    _servico.inicializarDadosMock();
    _atualizarDados();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _atualizarDados() {
    setState(() {
      _resumo = _servico.obterResumoFinanceiro(_mesAtual);
      _despesasPrioritarias = _servico.obterDespesasPrioritarias(_mesAtual);
      _receitasPrioritarias = _servico.obterReceitasPrioritarias(_mesAtual);
    });
  }

  void _mudarMes(int pagina) {
    final diferenca = pagina - _paginaInicial;
    final hoje = DateTime.now();
    _mesAtual = DateTime(hoje.year, hoje.month + diferenca);
    _atualizarDados();
  }

  String get _nomeMes {
    const meses = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'];
    return '${meses[_mesAtual.month - 1]} ${_mesAtual.year}';
  }

  void _marcarComoPago(String id) {
    _servico.marcarComoPago(id);
    _atualizarDados();
    _mostrarSnackBar('Movimentação marcada como paga!');
  }

  void _mostrarSnackBar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _navegarParaAdicionar() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TelaAdicionarMovimentacao()),
    );
    if (resultado == true) _atualizarDados();
  }

  void _navegarParaDetalhes() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaMovimentacoes(mesAtual: _mesAtual)),
    ).then((_) => _atualizarDados());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildCabecalhoMes(),
          Expanded(child: _buildPageView()),
        ],
      ),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Controle Financeiro',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      backgroundColor: Colors.blue.shade700,
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, color: Colors.white),
          onPressed: _atualizarDados,
        ),
      ],
    );
  }

  Widget _buildCabecalhoMes() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue.shade700,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.swipe, color: Colors.white70, size: 16),
          const SizedBox(width: 8),
          Text(
            _nomeMes,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.swipe, color: Colors.white70, size: 16),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: _mudarMes,
      itemBuilder: (context, index) => RefreshIndicator(
        onRefresh: () async => _atualizarDados(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CartaoSaldo(resumo: _resumo),
              const SizedBox(height: 16),
              if (_despesasPrioritarias.isNotEmpty) ...[
                ListaMovimentacoes(
                  movimentacoes: _despesasPrioritarias,
                  titulo: 'Despesas',
                  aoMarcarPago: _marcarComoPago,
                ),
                const SizedBox(height: 16),
              ],
              if (_receitasPrioritarias.isNotEmpty) ...[
                ListaMovimentacoes(
                  movimentacoes: _receitasPrioritarias,
                  titulo: 'Receitas',
                  aoMarcarPago: _marcarComoPago,
                ),
                const SizedBox(height: 16),
              ],
              GestureDetector(
                onTap: _navegarParaDetalhes,
                child: CartaoResumo(resumo: _resumo),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton.extended(
      onPressed: _navegarParaAdicionar,
      backgroundColor: Colors.blue.shade700,
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        'Nova Movimentação',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
