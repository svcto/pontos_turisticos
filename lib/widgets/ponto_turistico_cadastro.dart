
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pontos_turisticos/model/ponto_turistico.dart';

class PontoTuristicoCadastro extends StatefulWidget {
  final PontoTuristico? pontoTuristico;

  const PontoTuristicoCadastro({super.key, this.pontoTuristico});


  @override
  PontoTuristicoCadastroState createState() => PontoTuristicoCadastroState();

}

class PontoTuristicoCadastroState extends State<PontoTuristicoCadastro> {
  final formKey = GlobalKey<FormState>();
  final descricaoController = TextEditingController();
  final diferenciaisController = TextEditingController();
  final inclusaoController = TextEditingController();
  final _dateFormat = DateFormat("dd/MM/yyy");

  @override
  void initState() {
    super.initState();
    if (widget.pontoTuristico != null) {
      descricaoController.text = widget.pontoTuristico!.descricao;
      diferenciaisController.text = widget.pontoTuristico!.diferenciais;
      inclusaoController.text = widget.pontoTuristico!.inclusaoFormatada;
    }
  }

  _mostrarCalendario() {
    final dataFormatada = inclusaoController.text;
    var data = DateTime.now();
    if (dataFormatada.isNotEmpty) {
      data = _dateFormat.parse(dataFormatada);
    }
    showDatePicker(context: context,
        initialDate: data,
        firstDate: data.subtract(Duration(days: 365 * 5)),
        lastDate: data.add(Duration(days: 365 * 5))
    ).then((DateTime? dataSelecionada) {
      if (dataSelecionada != null) {
        inclusaoController.text = _dateFormat.format(dataSelecionada);
      }
    });
  }

  bool dadosValidados() => formKey.currentState?.validate() == true;

  PontoTuristico get novo => PontoTuristico(
      id: widget.pontoTuristico?.id ?? 0,
      descricao: descricaoController.text,
      diferenciais: diferenciaisController.text,
      inclusao: inclusaoController.text.isEmpty ?
      null : _dateFormat.parse(inclusaoController.text)
  );

  @override
  Widget build(BuildContext context) {
    return Form(key: formKey, child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(controller: descricaoController,
          decoration: const InputDecoration(labelText: "Descrição"),
          validator: (String? valor) {
            if (valor == null || valor.isEmpty) {
              return "Informe a descrição!";
            }
            return null;
          },
        ),
        TextFormField(controller: diferenciaisController,
          decoration: const InputDecoration(labelText: "Diferenciais"),
          validator: (String? valor) {
            if (valor == null || valor.isEmpty) {
              return "Informe os diferenciais!";
            }
            return null;
          },
        ),
        TextFormField(controller: inclusaoController,
          decoration: InputDecoration(labelText: "Inclusão",
              prefixIcon: IconButton(icon: const Icon(Icons.calendar_month),
                onPressed: _mostrarCalendario,
              ),
              suffixIcon: IconButton(icon: const Icon(Icons.close),
                onPressed: () => inclusaoController.clear(),
              )
          ),
          readOnly: true,
        )
      ],
    ));
  }
}