import 'package:flutter/material.dart';
import '../modelos/movimentacao.dart';
import '../servicos/servico_financeiro.dart';

class TelaAdicionarMovimentacao extends StatefulWidget {
  const TelaAdicionarMovimentacao({super.key});

  @override
  State<TelaAdicionarMovimentacao> createState() => _TelaAdicionarMovimentacaoState();
}

class _TelaAdicionarMovimentacaoState extends State<TelaAdicionarMovimentacao> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  
  TipoMovimentacao _tipo = TipoMovimentacao.despesa;
  bool _isPago = false;
  DateTime _dataVencimento = DateTime.now();

  @override
  void dispose() {
    _descricaoController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final valor = double.tryParse(_valorController.text.replaceAll(',', '.')) ?? 0;
      if (valor > 0) {
        final movimentacao = Movimentacao(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          descricao: _descricaoController.text,
          valor: valor,
          dataVencimento: _dataVencimento,
          tipo: _tipo,
          status: _isPago ? StatusMovimentacao.pago : StatusMovimentacao.pendente,
          dataPagamento: _isPago ? DateTime.now() : null,
        );
        
        ServicoFinanceiro().adicionarMovimentacao(movimentacao);
        Navigator.pop(context, true);
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Movimentação adicionada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, insira um valor válido'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _dataVencimento,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (data != null) {
      setState(() => _dataVencimento = data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Movimentação'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<TipoMovimentacao>(
                              title: const Text('Despesa'),
                              value: TipoMovimentacao.despesa,
                              groupValue: _tipo,
                              onChanged: (value) => setState(() => _tipo = value!),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<TipoMovimentacao>(
                              title: const Text('Receita'),
                              value: TipoMovimentacao.receita,
                              groupValue: _tipo,
                              onChanged: (value) => setState(() => _tipo = value!),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value?.isEmpty == true ? 'Insira uma descrição' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _valorController,
                decoration: const InputDecoration(
                  labelText: 'Valor (R\$)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final valor = double.tryParse(value?.replaceAll(',', '.') ?? '');
                  return valor == null || valor <= 0 ? 'Insira um valor válido' : null;
                },
              ),
              const SizedBox(height: 16),
              Card(
                child: ListTile(
                  title: const Text('Data de vencimento'),
                  subtitle: Text('${_dataVencimento.day}/${_dataVencimento.month}/${_dataVencimento.year}'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: _selecionarData,
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Já foi pago'),
                value: _isPago,
                onChanged: (value) => setState(() => _isPago = value),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _salvar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Text(
                    'Salvar Movimentação',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}