import 'package:controle_financeiro_app/modelos/transacao.dart';
import 'package:flutter/material.dart';

class FormularioTransacao extends StatefulWidget {
  final void Function(Transacao) onSalvar;
  const FormularioTransacao({super.key, required this.onSalvar});

  @override
  State<FormularioTransacao> createState() => FormularioTransacaoState();
}

class FormularioTransacaoState extends State<FormularioTransacao> {
  final _tituloCtrl = TextEditingController();
  final _valorCtrl = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();
  String _tipoSelecionado = 'despesa';

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

    widget.onSalvar(
      Transacao(
        titulo: titulo,
        valor: valor,
        data: _dataSelecionada,
        tipo: _tipoSelecionado,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
