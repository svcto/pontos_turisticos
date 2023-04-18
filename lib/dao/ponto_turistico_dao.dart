import 'package:pontos_turisticos/model/ponto_turistico.dart';

import '../database/database_provider.dart';

class PontoTuristicoDao {
  final databaseProvider = DatabaseProvider.instance;

  Future<bool> salvar(PontoTuristico ponto) async {
    final database = await databaseProvider.database;
    final valores = ponto.toMap();
    if (ponto.id == 0) {
      ponto.id = await database.insert(PontoTuristico.nomeTabela, valores);
      return true;
    } else {
      final registrosAtualizados = await database.update(
        PontoTuristico.nomeTabela,
        valores,
        where: '${PontoTuristico.campoId} = ?',
        whereArgs: [ponto.id],
      );
      return registrosAtualizados > 0;
    }
  }

  Future<bool> remover(int id) async {
    final database = await databaseProvider.database;
    final registrosAtualizados = await database.delete(
      PontoTuristico.nomeTabela,
      where: '${PontoTuristico.campoId} = ?',
      whereArgs: [id],
    );
    return registrosAtualizados > 0;
  }

  Future<List<PontoTuristico>> listar({
    String filtro = '',
    String campoOrdenacao = PontoTuristico.campoId,
    bool usarOrdemDecrescente = false,
  }) async {
    String? where;
    if (filtro.isNotEmpty) {
      where = "UPPER(${PontoTuristico.campoNome}) LIKE '${filtro.toUpperCase()}%'"
          " OR UPPER(${PontoTuristico.campoDetalhes}) LIKE '${filtro.toUpperCase()}%'";
    }
    var orderBy = campoOrdenacao;
    if (usarOrdemDecrescente) {
      orderBy += ' DESC';
    }
    final database = await databaseProvider.database;
    final resultado = await database.query(
      PontoTuristico.nomeTabela,
      columns: [
        PontoTuristico.campoId,
        PontoTuristico.campoNome,
        PontoTuristico.campoDiferenciais,
        PontoTuristico.campoInclusao,
        PontoTuristico.campoDetalhes
      ],
      where: where,
      orderBy: orderBy,
    );
    return resultado.map((m) => PontoTuristico.fromMap(m)).toList();
  }
}