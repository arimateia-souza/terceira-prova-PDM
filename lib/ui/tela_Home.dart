import 'package:flutter/material.dart';
import 'package:terceira_prova/ui/tela_Sobre.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  int _selectedIndex = 0;
  final List<Widget> _telas = [
    const TelaHomeConteudo(),
    //TelaCaptura(),
    //TelaPokemonCapturado(),
    const TelaSobre(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: _telas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Colors.yellow, // Defina a cor de fundo aqui
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red, // Cor dos ícones e rótulos selecionados
        unselectedItemColor:
            Colors.yellow, // Cor dos ícones e rótulos não selecionados
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Captura',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Capturados',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Sobre',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
          Text(
            'Projeto avaliativo da 3º unidade da disciplina de PDM',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
