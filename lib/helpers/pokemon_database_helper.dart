import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';
import 'package:terceira_prova/dao/database.dart';
import 'package:terceira_prova/domain/pokemon.dart';

class PokemonDatabaseHelper {
  static final PokemonDatabaseHelper _instance =
      PokemonDatabaseHelper._internal();
  factory PokemonDatabaseHelper() => _instance;

  PokemonDatabaseHelper._internal();

  AppDatabase? _pokemonDatabase;

  Future<AppDatabase> get pokemonDatabase async {
    _pokemonDatabase ??= await initDatabase();
    return _pokemonDatabase!;
  }

  Future<AppDatabase> initDatabase() async {
    String? databasesPath = await sqflite.getDatabasesPath();
    String path = join(databasesPath, "pokemon_database.db");

    return $FloorAppDatabase.databaseBuilder(path).build();
  }

  Future<Pokemon> savePokemon(Pokemon pokemon) async {
    final db = await pokemonDatabase;
    pokemon.id = await db.pokemonDao.insertPokemon(pokemon);
    return pokemon;
  }

  Future<List<Pokemon>> getAllPokemons() async {
    final db = await pokemonDatabase;
    return db.pokemonDao.findAllPokemon();
  }
}
