import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pontos_turisticos/model/ponto_turistico.dart';

import '../widgets/ponto_turistico_cadastro.dart';

class TelaPrincipalPage extends StatefulWidget {
  const TelaPrincipalPage({super.key});

  @override
  TelaPrincipalPageState createState() => TelaPrincipalPageState();
}

class TelaPrincipalPageState extends State<TelaPrincipalPage> {
  static const acaoEditar = 'editar';
  static const acaoExcluir = 'excluir';

  final list = <PontoTuristico>[
    PontoTuristico(
      id: 1,
      descricao: "Cataratas do Iguaçu",
      diferenciais: "Tem água",
      inclusao: DateTime.now()
    )
  ];

  var _ultimoId = 1;

  AppBar _criarAppBar() {
    return AppBar(
      title: const Text("Pontos Turísticos"),
      actions: [
        IconButton(onPressed: () => {}, icon: const Icon(Icons.filter_list)),
      ],
    );
  }

  void _abrirForm({PontoTuristico? item, int? index, required bool readOnly}) {
    final key = GlobalKey<PontoTuristicoCadastroState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(item == null
                ? "Novo ponto turístico"
                : "Alterar ponto turístico" + item.id.toString()),
            content: PontoTuristicoCadastro(key: key, pontoTuristico: item),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar")),
              if (!readOnly)
              TextButton(
                  onPressed: () => {
                    if (key.currentState != null &&
                        key.currentState!.dadosValidados())
                      {
                        setState(() {
                          final novo = key.currentState!.novo;
                          if (index == null) {
                            novo.id = ++_ultimoId;
                            list.add(novo);
                          } else {
                            list[index] = novo;
                          }

                          Navigator.pop(context);
                        })
                      }
                  },
                  child: const Text("Salvar"))
            ],
          );
        });
  }


  Widget _criarBody() {
    if (list.isEmpty) {
      return const Center(
        child: Text("Nenhum ponto turístico",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      );
    }
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final item = list[index];
          return ListTile(
              title: Column(
                children: <Widget>[
                  Container(
                      child: Row(
                        children: <Widget>[
                          Text('${item.id} - ${item.descricao}'),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _abrirForm(item: item, index: index, readOnly: false);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.remove_red_eye_rounded),
                            onPressed: () {
                              _abrirForm(item: item, index: index, readOnly: true);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _showAlertDialog(context, index);
                            },
                          ),

                        ],
                      ))
                ],
              ),
              subtitle:
              Text(item.diferenciais.isEmpty
                  ? "Sem diferenciais"
                  : 'Diferenciais: ${item.diferenciais}')
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: list.length);
  }

  void _showAlertDialog(BuildContext context, int index) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Não"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Sim"),
      onPressed:  () {
        setState(() {
          list.remove(list[index]);
        });

        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Atenção"),
      content: const Text("Deseja exluir esse registro?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _criarAppBar(),
      body: _criarBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirForm(readOnly: false),
        tooltip: "Novo ponto turístico",
        child: const Icon(Icons.add),
      ),
    );
  }

}