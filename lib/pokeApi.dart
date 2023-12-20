import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:terceira_prova/domain/pokemon.dart';

class PokeApi {
  Future<Pokemon?> getPokemonDetails(int id) async {
    final apiUrl = 'https://pokeapi.co/api/v2/pokemon/$id';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Pokemon.fromMap(data);
      } else {
        print('Erro na busca dos dados do Pokémon: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro ao buscar dados do Pokémon: $e');
      return null;
    }
  }
}
