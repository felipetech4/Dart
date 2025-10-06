import 'package:controle_financeiro_app/modelos/transacao.dart';
import 'package:flutter/material.dart';

class FormularioTransacao extends StatefulWidget {
  final void Function(Transacao) salvarForm;
  const FormularioTransacao({super.key, required this.salvarForm});

  @override
  State<FormularioTransacao> createState() => FormularioTransacaoState();
}

class FormularioTransacaoState extends State<FormularioTransacao> {
  final _tituloCtrl = TextEditingController();
  final _valorCtrl = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();
  String _tipoSelecionado = 'despesa';
  bool _statusPago = false;
  final List<String> _categorias = [
    'Alimentacao',
    'Moradia',
    'Transporte',
    'Educação',
    'Lazer',
    'Salario',
    'Outros',
  ];
  String _categoriaSelecionada = 'Alimentacao';

  void _abrirDatePicker() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (data != null) setState(() => _dataSelecionada = data);
  }

  void _submit() {
    final titulo = _tituloCtrl.text.trim();
    final valor = double.tryParse(_valorCtrl.text.replaceAll(',', '.')) ?? 0;
    if (titulo.isEmpty || valor <= 0) return; //Validação

    widget.salvarForm(
      Transacao(
        titulo: titulo,
        valor: valor,
        data: _dataSelecionada,
        tipo: _tipoSelecionado,
        categoria: _categoriaSelecionada,
        statusPago: _statusPago,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _tituloCtrl,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _valorCtrl,
              decoration: const InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Data: ${_dataSelecionada.day}/${_dataSelecionada.month}/${_dataSelecionada.year}',
                  ),
                ),
                TextButton(
                  onPressed: _abrirDatePicker,
                  child: const Text('Selecionar Data'),
                ),
              ],
            ),
            DropdownButton<String>(
              value: _tipoSelecionado,
              items: const [
                DropdownMenuItem(value: 'despesa', child: Text('Despesa')),
                DropdownMenuItem(value: 'receita', child: Text('Receita')),
              ],
              onChanged: (v) => setState(() => _tipoSelecionado = v!),
            ),
            DropdownButton<String>(
              value: _categoriaSelecionada,
              isExpanded: true,
              items:
                  _categorias.map((categoria) {
                    return DropdownMenuItem(
                      value: categoria,
                      child: Text(categoria),
                    );
                  }).toList(),
              onChanged: (val) => setState(() => _categoriaSelecionada = val!),
            ),
            SwitchListTile(
              title: const Text('Pago?'),
              value: _statusPago,
              onChanged: (val) => setState(() => _statusPago = val),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _submit, child: const Text('Salvar')),
          ],
        ),
      ),
    );
  }
}
