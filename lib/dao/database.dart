// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:terceira_prova/dao/dao.dart';
import 'package:terceira_prova/domain/pokemon.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Pokemon])
abstract class AppDatabase extends FloorDatabase {
  PokemonDao get pokemonDao;
}