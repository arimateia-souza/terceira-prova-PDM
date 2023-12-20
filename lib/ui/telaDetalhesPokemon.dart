import 'package:flutter/material.dart';
import 'package:terceira_prova/domain/pokemon.dart';
import 'package:terceira_prova/pokemonDatabaseHelper.dart';
import 'package:terceira_prova/pokeApi.dart';

class TelaDetalhesPokemon extends StatefulWidget {
  final int id;

  TelaDetalhesPokemon({required this.id, Pokemon? pokemon})
      : _pokemon = pokemon;

  final Pokemon? _pokemon;

  @override
  _TelaDetalhesPokemonState createState() => _TelaDetalhesPokemonState();
}

class _TelaDetalhesPokemonState extends State<TelaDetalhesPokemon> {
  late Future<Pokemon> _pokemonDetails;
  final PokeApi _pokemonApiHelper = PokeApi();

  @override
  void initState() {
    super.initState();
    _pokemonDetails = _fetchPokemonDetails();
  }

  Future<Pokemon> _fetchPokemonDetails() async {
    final localDb = await PokemonDatabaseHelper().pokemonDatabase;
    final localPokemon = await localDb.pokemonDao.findPokemonById(widget.id);

    if (localPokemon != null) {
      return localPokemon;
    }

    final apiPokemon = await _pokemonApiHelper.getPokemonDetails(widget.id);

    if (apiPokemon != null) {
      await localDb.pokemonDao.insertPokemon(apiPokemon);
    }

    return apiPokemon ??
        Pokemon(
            id: widget.id,
            nome: 'Não encontrado',
            tipos: '',
            urlImagem: '',
            baseExperiencia: 0,
            habilidades: '',
            altura: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Pokémon'),
      ),
      body: FutureBuilder<Pokemon>(
        future: _pokemonDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Erro ao carregar detalhes do Pokémon.'));
          } else if (snapshot.hasData) {
            final pokemon = snapshot.data!;
            // Seu código existente ...

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID: ${pokemon.id}',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Nome: ${pokemon.nome}',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height:
                        300.0, // Ajuste o tamanho do espaço para acomodar a imagem
                    width: double.infinity, // Define a largura total disponível
                    child: Container(
                      alignment: Alignment.center, // Centraliza a imagem
                      child: Image.network(
                        pokemon.urlImagem,
                        height: 300.0, // Ajuste o tamanho da imagem do Pokémon
                        width: 300.0, // Ajuste o tamanho da imagem do Pokémon
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    'Tipos: ${pokemon.tipos}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    'Base de Experiência: ${pokemon.baseExperiencia}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    'Habilidades: ${pokemon.habilidades}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    'Altura: ${pokemon.altura}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            );

// Restante do seu código...
          } else {
            return const Center(child: Text('Erro desconhecido.'));
          }
        },
      ),
    );
  }
}
