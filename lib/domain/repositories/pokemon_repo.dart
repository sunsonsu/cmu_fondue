import 'package:cmu_fondue/domain/entities/pokemon_entity.dart';

abstract class PokemonRepo {
  Future<PokemonInfo> getPokemonInfo(int id);
}
