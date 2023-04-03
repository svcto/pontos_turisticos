import 'package:intl/intl.dart';

class PontoTuristico {
  static const campoId = "id";
  static const campoDescricao = "descricao";
  static const campoDiferenciais = "diferenciais";
  static const campoInclusao = "inclusao";

  int id;
  String descricao;
  String diferenciais;
  DateTime? inclusao = DateTime.now();

  PontoTuristico({
    required this.id,
    required this.descricao,
    required this.diferenciais,
    required this.inclusao
  });

  String get inclusaoFormatada{
    if (inclusao == null) {
      return "";
    }
    return DateFormat("dd/MM/yyy").format(inclusao!);
  }
}
