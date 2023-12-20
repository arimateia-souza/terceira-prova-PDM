import 'package:flutter/material.dart';
import 'package:terceira_prova/dao/database.dart';
import 'package:terceira_prova/domain/pokemon.dart';

class TelaSoltarPokemon extends StatelessWidget {
  final Pokemon pokemon;

  TelaSoltarPokemon({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soltar Pokémon'),
      ),
      // ... (restante do código)

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${pokemon.nome}'),
            Text('ID: ${pokemon.id}'),
            const SizedBox(height: 16),
            // Ajuste o tamanho da imagem e centralize-a
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
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _confirmarLiberacao(context, pokemon);
                  },
                  child: const Text('Confirmar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmarLiberacao(
      BuildContext context, Pokemon pokemon) async {
    final pokemonDatabase =
        await $FloorAppDatabase.databaseBuilder('pokemon_database.db').build();

    try {
      final linhasAfetadas =
          await pokemonDatabase.pokemonDao.deletePokemon(pokemon);

      if (linhasAfetadas != null && linhasAfetadas > 0) {
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao soltar o Pokémon. Tente novamente!'),
          ),
        );
      }
    } catch (e) {
      print('Exceção: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao soltar o Pokémon. Tente novamente.'),
        ),
      );
    }
  }
}
