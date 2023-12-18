import 'package:flutter/material.dart';
import 'package:terceira_prova/pokeApi.dart';
import 'package:terceira_prova/ui/tela_Captura.dart';
import 'package:terceira_prova/ui/tela_Sobre.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  final PokeApi _pokeApi = PokeApi(); // Instância da classe PokeApi
  Map<String, dynamic>? _apiData;

  @override
  void initState() {
    super.initState();
    fetchDataAndUpdateUI();
  }

  Future<void> fetchDataAndUpdateUI() async {
    try {
      final data = await _pokeApi.fetchData();
      setState(() {
        _apiData = data; // Atualiza os dados recebidos da API
      });
    } catch (e) {
      setState(() {
        _apiData = null; // Limpa os dados em caso de erro
      });
      print('Erro ao carregar dados: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TelaSobre()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TelaCaptura()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: _apiData != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nome: ${_apiData!['nome']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Tipo: ${_apiData!['tipo']}'),
                  Text('Altura: ${_apiData!['altura']}'),
                  Text('Habilidade: ${_apiData!['habilidade']}'),
                  Text('Peso: ${_apiData!['peso']}'),
                ],
              )
            : CircularProgressIndicator(), // Mostra indicador de carregamento
      ),
    );
  }
}
