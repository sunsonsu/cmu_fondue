import 'dart:convert';

import 'package:cmu_fondue/domain/entities/pokemon_entity.dart';
import 'package:cmu_fondue/domain/repositories/pokemon_repo.dart';
import 'package:http/http.dart' as http;

class PokemonRepoImpl implements PokemonRepo {
  PokemonRepoImpl({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  @override
  Future<PokemonInfo> getPokemonInfo(int id) async {
    final response = await _client.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load Pokemon info (status ${response.statusCode})',
      );
    }
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return PokemonInfo.fromJson(decoded);
  }
}
