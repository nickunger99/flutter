import 'package:Tasks/components/task.dart';
import 'package:Tasks/data/database.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = '''CREATE TABLE $_tablename(
$_name TEXT, $_difficulty INTEGER, $_image TEXT);''';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task tarefa) async {
    if (kDebugMode) {
      print('Iniciando o save: ');
    }
    final Database database = await getDatabase();
    var itemExists = await find(tarefa.nome);
    Map<String, dynamic> taskMap = toMap(tarefa);
    if (itemExists.isEmpty) {
      if (kDebugMode) {
        print('A tarefa não existia.');
      }
      return await database.insert(_tablename, taskMap);
    } else {
      if (kDebugMode) {
        print('A tarefa já existe!');
      }
      return await database.update(_tablename, taskMap,
          where: '$_name = ?', whereArgs: [tarefa.nome]);
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    if (kDebugMode) {
      print('Convertendo tarefa em Map: ');
    }
    final Map<String, dynamic> mapaDeTarefas = {};
    mapaDeTarefas[_name] = tarefa.nome;
    mapaDeTarefas[_difficulty] = tarefa.dificuldade;
    mapaDeTarefas[_image] = tarefa.foto;
    if (kDebugMode) {
      print('Mapa de Tarefas: $mapaDeTarefas');
    }
    return mapaDeTarefas;
  }

  Future<List<Task>> findAll() async {
    if (kDebugMode) {
      print('Acessando o findAll: ');
    }
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(_tablename);
    if (kDebugMode) {
      print('Procurando dados no banco de dados... encontrado: $result');
    }
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    if (kDebugMode) {
      print('Convertendo to List: ');
    }
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(linha[_name], linha[_image], linha[_difficulty]);
      tarefas.add(tarefa);
    }
    if (kDebugMode) {
      print('Lista de Tarefas: $tarefas');
    }
    return tarefas;
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    if (kDebugMode) {
      print('Acessando o find: ');
    }
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
    if (kDebugMode) {
      print('Tarefa encontrada: ${toList(result)}');
    }
    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    if (kDebugMode) {
      print('Deletando tarefa: $nomeDaTarefa');
    }
    final Database database = await getDatabase();
    return database
        .delete(_tablename, where: '$_name = ?', whereArgs: [nomeDaTarefa]);
  }
}
