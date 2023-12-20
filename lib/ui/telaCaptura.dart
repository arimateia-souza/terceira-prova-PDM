import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:terceira_prova/domain/pokemon.dart';
import 'package:terceira_prova/pokemonDatabaseHelper.dart';

class TelaCaptura extends StatefulWidget {
  @override
  _TelaCapturaState createState() => _TelaCapturaState();
}

class _TelaCapturaState extends State<TelaCaptura> {
  late List<Pokemon> _pokemonsCapturados;
  late List<Pokemon> _pokemonsDisponiveis;
  late bool _conectado;
  late PokemonDatabaseHelper _pokemonDatabaseHelper;

  final String _pokeApiUrl = 'https://pokeapi.co/api/v2/pokemon';

  @override
  void initState() {
    super.initState();
    _pokemonsCapturados = [];
    _pokemonsDisponiveis = [];
    _conectado = false;
    _pokemonDatabaseHelper = PokemonDatabaseHelper();
    _verificarConexao();
  }

  Future<void> _verificarConexao() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _conectado = connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi;
    });

    if (_conectado) {
      await _carregarPokemonsDisponiveis();
    }
  }

  Future<void> _carregarDetalhesPokemon(int id) async {
    final response = await http.get(Uri.parse('$_pokeApiUrl/$id/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        _pokemonsDisponiveis.add(Pokemon(
          id: id,
          nome: data['name'],
          tipos: 'Tipo ${id % 3 + 1}',
          urlImagem: data['sprites']['front_default'],
          baseExperiencia: data['base_experience'],
          habilidades: 'Habilidade ${id % 5 + 1}',
          altura: data['height'] / 10.0,
        ));
      });
    } else {
      throw Exception('Falha ao carregar os detalhes do Pokemon');
    }
  }

  Future<void> _carregarPokemonsDisponiveis() async {
    List<int> idPokemons = List.generate(1017, (index) => index + 1);
    idPokemons.shuffle();

    List<int> idSelecionados = idPokemons.sublist(0, 6);

    for (int id in idSelecionados) {
      await _carregarDetalhesPokemon(id);
    }
  }

  Future<void> _capturarPokemon(Pokemon pokemon) async {
    final db = await _pokemonDatabaseHelper.pokemonDatabase;
    await db.pokemonDao.insertPokemon(pokemon);

    setState(() {
      _pokemonsCapturados.add(pokemon);
    });
  }

  Widget _buildPokemonCard(Pokemon pokemon) {
    bool capturado = _pokemonsCapturados.contains(pokemon);

    return Card(
      child: ListTile(
        title: Text(
          pokemon.nome.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: SizedBox(
          height: 200, // Aumente o espaço para acomodar a pokebola
          width: 200,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.network(
                        pokemon.urlImagem!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: GestureDetector(
                        onTap:
                            capturado ? null : () => _capturarPokemon(pokemon),
                        child: Icon(
                          Icons.catching_pokemon,
                          size: 60, // Ajuste o tamanho da pokebola
                          color: capturado ? Colors.grey : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant TelaCaptura oldWidget) {
    super.didUpdateWidget(oldWidget);
    _verificarConexao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capturar Pokémon'),
      ),
      body: _conectado
          ? ListView.builder(
              itemCount: _pokemonsDisponiveis.length,
              itemBuilder: (context, index) {
                return _buildPokemonCard(_pokemonsDisponiveis[index]);
              },
            )
          : const Center(
              child: Text('Sem conexão com a Internet'),
            ),
    );
  }
}
