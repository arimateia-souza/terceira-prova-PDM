import 'dart:math';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:terceira_prova/dao/database.dart';
import 'package:terceira_prova/domain/pokemon.dart';
import 'package:terceira_prova/pokeApi.dart';

class TelaCaptura extends StatefulWidget {
  const TelaCaptura({Key? key}) : super(key: key);

  @override
  _TelaCapturaState createState() => _TelaCapturaState();
}

class _TelaCapturaState extends State<TelaCaptura> {
  final List<Pokemon> _pokemons = [];
  final List<int> _pokemonsCapturados = [];
  final PokeApi _pokeApi = PokeApi();

  @override
  void initState() {
    super.initState();
    _fetchPokemonData();
  }

  Future<void> _fetchPokemonData() async {
    try {
      final List<Pokemon> data = await _pokeApi.fetchData();
      setState(() {
        _pokemons.addAll(data);
      });
    } catch (e) {
      print('Erro ao carregar dados: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Captura'),
      ),
      body: FutureBuilder(
        future: _verificarConexao(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao verificar a conexão'));
          } else {
            if (snapshot.data == ConnectivityResult.none) {
              return const Center(child: Text('Sem conexão com a internet'));
            } else {
              return _buildListView();
            }
          }
        },
      ),
    );
  }

  Future<ConnectivityResult> _verificarConexao() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult;
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _pokemons.length,
      itemBuilder: (context, index) {
        Pokemon pokemon = _pokemons[index];
        bool capturado = _pokemonsCapturados.contains(pokemon.id);

        return PokemonCapturado(
          pokemon: pokemon,
          capturado: capturado,
          onCapturar: () => _capturarPokemon(pokemon),
        );
      },
    );
  }

  void _capturarPokemon(Pokemon pokemon) {
    if (!_pokemonsCapturados.contains(pokemon.id)) {
      _pokemonsCapturados.add(pokemon.id);
      _salvarPokemonCapturado(pokemon);
    }
  }

  Future<void> _salvarPokemonCapturado(Pokemon pokemon) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final pokemonDao = database.pokemonDao;

    await pokemonDao.insertPokemon(pokemon);

    setState(() {
      _pokemonsCapturados.add(pokemon.id);
    });
  }
}

class PokemonCapturado extends StatelessWidget {
  final Pokemon pokemon;
  final bool capturado;
  final VoidCallback onCapturar;

  const PokemonCapturado({
    required this.pokemon,
    required this.capturado,
    required this.onCapturar,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(pokemon.nome),
      subtitle: Text('Tipo: ${pokemon.tipo}'),
      trailing: ElevatedButton(
        onPressed: capturado ? null : onCapturar,
        style: ElevatedButton.styleFrom(
          backgroundColor: capturado ? Colors.grey : Colors.red,
        ),
        child: const Text('Capturar'),
      ),
    );
  }
}
