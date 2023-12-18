//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokeApi {
  Future fetchData() async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/'));

    if (response.statusCode == 200) {
      // Se a requisição for bem-sucedida, decodifique os dados JSON
      var data = json.decode(response.body);
      return data;
    } else {
      // Se a requisição falhar, lance uma exceção
      throw Exception('Failed to load data');
    }
  }
}
