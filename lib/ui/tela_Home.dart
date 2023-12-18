import 'package:flutter/material.dart';
//import 'package:terceira_prova/ui/tela_Captura.dart';
import 'tela_sobre.dart';

class TelaHome extends StatelessWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela home'),
        actions: [
          // Sobre os desenvolvedores
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TelaSobre()),
              );
            },
          ),
          // Captura
          IconButton(
            icon: const Icon(Icons.photo), //mudar icon depois
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const TelaSobre()), //alterar quando tiver ok
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('3º Avaliação PDM'),
          ],
        ),
      ),
    );
  }
}
