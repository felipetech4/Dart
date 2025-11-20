import 'package:flutter/material.dart';
import '../modelos/movimentacao.dart';
import '../servicos/servico_financeiro.dart';

class TelaEditarMovimentacao extends StatefulWidget {
  final Movimentacao movimentacao;

  const TelaEditarMovimentacao({super.key, required this.movimentacao});

  @override
  State<TelaEditarMovimentacao> createState() => _TelaEditarMovimentacaoState();
}

class _TelaEditarMovimentacaoState extends State<TelaEditarMovimentacao> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  late DateTime _dataVencimento;
  late TipoMovimentacao _tipo;
  late StatusMovimentacao _status;

  @override
  void initState() {
    super.initState();
    _descricaoController.text = widget.movimentacao.descricao;
    _valorController.text = widget.movimentacao.valor.toStringAsFixed(2);
    _dataVencimento = widget.movimentacao.dataVencimento;
    _tipo = widget.movimentacao.tipo;
    _status = widget.movimentacao.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Movimentação'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (value) => value?.isEmpty == true ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _valorController,
                decoration: const InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                validator: (value) => value?.isEmpty == true ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<TipoMovimentacao>(
                value: _tipo,
                decoration: const InputDecoration(labelText: 'Tipo'),
                items: TipoMovimentacao.values.map((tipo) => DropdownMenuItem(
                  value: tipo,
                  child: Text(tipo == TipoMovimentacao.receita ? 'Receita' : 'Despesa'),
                )).toList(),
                onChanged: (value) => setState(() => _tipo = value!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<StatusMovimentacao>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: StatusMovimentacao.values.map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status == StatusMovimentacao.pago ? 'Pago' : 'Pendente'),
                )).toList(),
                onChanged: (value) => setState(() => _status = value!),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text('Data: ${_formatarData(_dataVencimento)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _selecionarData,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _salvar,
                  child: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _dataVencimento,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (data != null) setState(() => _dataVencimento = data);
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final movimentacaoAtualizada = widget.movimentacao.copyWith(
        descricao: _descricaoController.text,
        valor: double.parse(_valorController.text),
        dataVencimento: _dataVencimento,
        tipo: _tipo,
        status: _status,
        dataPagamento: _status == StatusMovimentacao.pago ? DateTime.now() : null,
      );

      ServicoFinanceiro().atualizarMovimentacao(movimentacaoAtualizada);
      Navigator.pop(context, true);
    }
  }

  String _formatarData(DateTime data) =>
      '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
}