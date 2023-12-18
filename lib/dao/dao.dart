import 'package:floor/floor.dart';
import 'package:terceira_prova/domain/pokemon.dart';

@dao
abstract class PokemonDao {
  @insert
  Future<void> insertPokemon(Pokemon pokemon);

  @delete
  Future<void> deletePokemon(Pokemon pokemon);

  @Query('SELECT * FROM Pokemon')
  Future<List<Pokemon>> findAllPokemon();

  @Query('SELECT * FROM Pokemon WHERE id = :id')
  Stream<Pokemon?> findPokemonById(int id);
}
