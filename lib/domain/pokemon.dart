// entity/person.dart

import 'dart:ffi';

import 'package:floor/floor.dart';

@entity
class Pokemon {
  @primaryKey
  final int id;

  final String nome;
  final String tipo;
  final String experiencia;
  final String habilidade;
  final String oculta;

  Pokemon(this.id, this.nome, this.tipo, this.experiencia, this.habilidade,
      this.oculta);
}
