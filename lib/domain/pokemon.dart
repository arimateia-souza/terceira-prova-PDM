//import 'dart:ffi';
import 'package:floor/floor.dart';

@entity
class Pokemon {
  @primaryKey
  final int id;

  final String nome;
  final String tipo;
  final String altura;
  final String habilidade;
  final String peso;

  Pokemon(
      this.id, this.nome, this.tipo, this.altura, this.habilidade, this.peso);
}
