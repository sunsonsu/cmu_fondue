import 'package:cmu_fondue/domain/entities/pokemon_entity.dart';
import 'package:cmu_fondue/domain/repositories/pokemon_repo.dart';

class GetPokemonInfoUseCase {
  const GetPokemonInfoUseCase(this._repository);

  final PokemonRepo _repository;

  Future<PokemonInfo> call(int id) => _repository.getPokemonInfo(id);
}
