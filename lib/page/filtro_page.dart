import 'package:flutter/material.dart';
import 'package:pontos_turisticos/model/ponto_turistico.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FiltroPage extends StatefulWidget {
  static const routeName = '/filtro';
  static const chaveCampoOrdenacao = "campoOrdenacao";
  static const chaveUsarOrdemDescrescente = "usarOrdemDescrescente";
  static const chaveCampoDescricao = "campoDescricao";
  static const chaveCampoDetalhes = "campoDetalhes";

  @override
  FiltroPageState createState() => FiltroPageState();
}

class FiltroPageState extends State<FiltroPage> {
  final _camposParaOrdenacao = {
    PontoTuristico.campoId: 'Código',
    PontoTuristico.campoDescricao: 'Descrição',
    PontoTuristico.campoDetalhes: 'Detalhes',
    PontoTuristico.campoDiferenciais: 'Diferenciais',
    PontoTuristico.campoInclusao: 'Inclusão'
  };
  late final SharedPreferences _prefes;
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _detalhesController = TextEditingController();
  String _campoOrdenacao = PontoTuristico.campoId;
  bool _usarOrdemDescrescente = false;
  bool _alterouValores = false;

  @override
  void initState() {
    _carregaPreferences();
  }

  void _carregaPreferences() async {
    _prefes = await SharedPreferences.getInstance();
    setState(() {
      _campoOrdenacao =
          _prefes.getString(FiltroPage.chaveCampoOrdenacao) ?? PontoTuristico.campoId;
      _usarOrdemDescrescente =
          _prefes.getBool(FiltroPage.chaveUsarOrdemDescrescente) == true;
      _descricaoController.text =
          _prefes.getString(FiltroPage.chaveCampoDescricao) ?? '';
      _detalhesController.text =
          _prefes.getString(FiltroPage.chaveCampoDetalhes) ?? '';
    });
  }

  Widget _criarBody() {
    return ListView(children: [
      Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Text('Campos para ordenação')),
      for (final campo in _camposParaOrdenacao.keys)
        Row(
          children: [
            Radio(
                value: campo,
                groupValue: _campoOrdenacao,
                onChanged: _onCampoParaOrdenacaoChanged),
            Text(_camposParaOrdenacao[campo]!)
          ],
        ),
      const Divider(),
      Row(
        children: [
          Checkbox(
              value: _usarOrdemDescrescente,
              onChanged: _onUsarOrdemDecrescenteChanged),
          const Text('Usar ordem descrescente')
        ],
      ),
      const Divider(),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
            decoration: const InputDecoration(
              labelText: 'Descrição ou detalhes começa com...',
            ),
            controller: _descricaoController,
            onChanged: _onFiltroDescricaoChanged),
      ),

      // Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 10),
      //   child: TextField(
      //       decoration: const InputDecoration(
      //         labelText: 'Detalhes começa com...',
      //       ),
      //       controller: _detalhesController,
      //       onChanged: _onFiltroDiferenciaisChanged),
      // )
    ]);
  }

  void _onFiltroDescricaoChanged(String? value) {
    _prefes.setString(FiltroPage.chaveCampoDescricao, value!);
    _alterouValores = true;
  }

  void _onFiltroDiferenciaisChanged(String? value) {
    _prefes.setString(FiltroPage.chaveCampoDetalhes, value!);
    _alterouValores = true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onVoltarClick,
        child: Scaffold(
          appBar: AppBar(title: const Text('Filtro e Ordenação')),
          body: _criarBody(),
        ));
  }

  Future<bool> _onVoltarClick() async {
    Navigator.of(context).pop(_alterouValores);
    return true;
  }

  void _onCampoParaOrdenacaoChanged(String? value) {
    _prefes.setString(FiltroPage.chaveCampoOrdenacao, value!);
    _alterouValores = true;
    setState(() {
      _campoOrdenacao = value;
    });
  }

  void _onUsarOrdemDecrescenteChanged(bool? value) {
    _prefes.setBool(FiltroPage.chaveUsarOrdemDescrescente, value!);
    _alterouValores = true;
    setState(() {
      _usarOrdemDescrescente = value;
    });
  }
}
