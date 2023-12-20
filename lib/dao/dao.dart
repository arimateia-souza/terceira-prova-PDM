import 'package:floor/floor.dart';
import 'package:terceira_prova/domain/pokemon.dart';

@dao
abstract class PokemonDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertPokemon(Pokemon pokemon);

  @delete
  Future<int> deletePokemon(Pokemon pokemon);

  @Query('SELECT * FROM Pokemon')
  Future<List<Pokemon>> findAllPokemon();

  @Query('SELECT * FROM Pokemon WHERE id = :id')
  Future<Pokemon?> findPokemonById(int id);
}
