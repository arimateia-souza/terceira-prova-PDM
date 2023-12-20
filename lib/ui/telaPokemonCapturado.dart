import 'package:flutter/material.dart';
import 'package:terceira_prova/domain/pokemon.dart';
import 'package:terceira_prova/pokemonDatabaseHelper.dart';
import 'package:terceira_prova/ui/telaDetalhesPokemon.dart';
import 'package:terceira_prova/ui/telaSoltarPokemon.dart';

class TelaPokemonCapturado extends StatefulWidget {
  @override
  _TelaPokemonCapturadoState createState() => _TelaPokemonCapturadoState();

  static _TelaPokemonCapturadoState? of(BuildContext context) {
    return context.findAncestorStateOfType<_TelaPokemonCapturadoState>();
  }
}

class _TelaPokemonCapturadoState extends State<TelaPokemonCapturado> {
  late Future<List<Pokemon>> _capturedPokemonList;
  late PokemonDatabaseHelper _pokemonDatabaseHelper;

  @override
  void initState() {
    super.initState();
    _pokemonDatabaseHelper = PokemonDatabaseHelper();
    _capturedPokemonList = _fetchCapturedPokemons();
  }

  Future<List<Pokemon>> _fetchCapturedPokemons() async {
    final db = await _pokemonDatabaseHelper.pokemonDatabase;
    return (await db.pokemonDao.findAllPokemon()) ?? [];
  }

  Future<void> adicionarPokemonCapturado(Pokemon pokemon) async {
    final db = await _pokemonDatabaseHelper.pokemonDatabase;
    await db.pokemonDao.insertPokemon(pokemon);

    setState(() {
      _capturedPokemonList = _fetchCapturedPokemons();
    });
  }

  Future<void> removerPokemonCapturado(Pokemon pokemon) async {
    final db = await _pokemonDatabaseHelper.pokemonDatabase;
    await db.pokemonDao.deletePokemon(pokemon);

    setState(() {
      _capturedPokemonList = _fetchCapturedPokemons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémons Capturados'),
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: _capturedPokemonList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text(
                    'Ocorreu um erro ao tentar carregar os pokemons, tente novamente!'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Hey, você ainda não capturou nenhum pokemon :( '));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pokemon = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaDetalhesPokemon(
                          id: pokemon.id,
                          pokemon: pokemon,
                        ),
                      ),
                    );
                  },
                  onLongPress: () async {
                    final resultado = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TelaSoltarPokemon(pokemon: pokemon),
                      ),
                    );
                    if (resultado == true) {
                      await removerPokemonCapturado(pokemon);
                    }
                  },
                  child: ListTile(
                    leading: Image.network(
                      pokemon.urlImagem,
                      height:
                          50, // Ajuste o tamanho da imagem conforme necessário
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(pokemon.nome),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Aconteceu um erro desconhecido'));
          }
        },
      ),
    );
  }
}
