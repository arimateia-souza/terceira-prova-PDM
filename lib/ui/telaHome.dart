import 'package:flutter/material.dart';
import 'package:terceira_prova/ui/telaCaptura.dart';
import 'package:terceira_prova/ui/telaPokemonCapturado.dart';
import 'package:terceira_prova/ui/telaSobre.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.add), text: 'Capturar'),
            Tab(icon: Icon(Icons.work_outline), text: 'Capturado'),
            Tab(icon: Icon(Icons.info), text: 'Sobre'),
          ],
        ),
      ),
      body: Container(
        child: TabBarView(
          controller: _tabController,
          children: [
            const PresentationAndContentScreen(),
            TelaCaptura(),
            TelaPokemonCapturado(),
            const TelaSobre()
          ],
        ),
      ),
    );
  }
}

class PresentationAndContentScreen extends StatelessWidget {
  const PresentationAndContentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            color: Colors.yellow[200],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Informações sobre o Aplicativo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Este projeto é uma atividade de programação para dispositivos móveis, proposta pelo professor Taniro Chacon. O trabalho consiste em utilizar a API de Pokémon para extrair informações e manipulá-las utilizando o banco de dados Floor. Funcionalidades implementadas: criar, deletar, listar todos, listar por ID os Pokémons. Além disso, serão exibidos 6 Pokémons aleatórios para serem capturados por uma pokébola e salvos no banco.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              TelaHomeConteudo(),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaHomeConteudo extends StatelessWidget {
  const TelaHomeConteudo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
