import 'package:intl/intl.dart';

class PontoTuristico {
  static const campoId = "id";
  static const campoNome = "nome";
  static const campoDetalhes = "detalhes";
  static const campoDiferenciais = "diferenciais";
  static const campoInclusao = "inclusao";
  static const nomeTabela = "ponto_turistico";

  int id;
  String nome;
  String detalhes;
  String diferenciais;
  DateTime? inclusao = DateTime.now();

  PontoTuristico({
    required this.id,
    required this.nome,
    required this.diferenciais,
    required this.inclusao,
    required this.detalhes
  });

  String get inclusaoFormatada{
    if (inclusao == null) {
      return "";
    }
    return DateFormat("dd/MM/yyy").format(inclusao!);
  }

  Map<String, dynamic> toMap() => {
    campoId: id == 0 ? null : id,
    campoNome: nome,
    campoDetalhes: detalhes,
    campoDiferenciais: diferenciais,
    campoInclusao:
    inclusao == null ? null : DateFormat("yyyy-MM-dd").format(inclusao!)
  };

  factory PontoTuristico.fromMap(Map<String, dynamic> map) => PontoTuristico(
    id: map[campoId] is int ? map[campoId] : null,
    nome: map[campoNome] is String ? map[campoNome] : '',
    inclusao: map[campoInclusao] is String
        ? DateFormat("yyyy-MM-dd").parse(map[campoInclusao])
        : null,
    detalhes: map[campoDetalhes] is String ? map[campoDetalhes] : '',
    diferenciais: map[campoDiferenciais] is String ? map[campoDiferenciais] : '',
  );
}
