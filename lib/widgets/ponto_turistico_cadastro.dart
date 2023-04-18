
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
  final nomeController = TextEditingController();
  final diferenciaisController = TextEditingController();
  final detalhesController = TextEditingController();
  final inclusaoController = TextEditingController();
  final _dateFormat = DateFormat("dd/MM/yyy");

  @override
  void initState() {
    super.initState();
    if (widget.pontoTuristico != null) {
      nomeController.text = widget.pontoTuristico!.nome;
      diferenciaisController.text = widget.pontoTuristico!.diferenciais;
      inclusaoController.text = widget.pontoTuristico!.inclusaoFormatada;
      detalhesController.text = widget.pontoTuristico!.detalhes;
    } else {
      inclusaoController.text = _dateFormat.format(DateTime.now());
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
      nome: nomeController.text,
      diferenciais: diferenciaisController.text,
      detalhes: detalhesController.text,
      inclusao: inclusaoController.text.isEmpty ?
      null : _dateFormat.parse(inclusaoController.text)
  );

  @override
  Widget build(BuildContext context) {
    return Form(key: formKey, child: SingleChildScrollView(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(controller: nomeController,
          decoration: const InputDecoration(labelText: "Descrição"),
          validator: (String? valor) {
            if (valor == null || valor.isEmpty) {
              return "Informe o nome!";
            }
            return null;
          },
        ),
        TextFormField(controller: detalhesController,
          decoration: const InputDecoration(labelText: "Detalhes"),
          validator: (String? valor) {
            if (valor == null || valor.isEmpty) {
              return "Informe os detalhes!";
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
          decoration: InputDecoration(labelText: "Inclusão" ),
          readOnly: true,
        )
      ],
    )) );
  }
}