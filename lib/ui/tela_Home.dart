import 'package:flutter/material.dart';

class TelaHome extends StatelessWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela home'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('3º Avaliação PDM - teste'),
          ],
        ),
      ),
      //botao?
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: const Icon(Icons.add),
      ),*/
    );
  }
}
