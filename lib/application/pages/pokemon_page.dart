import 'package:cmu_fondue/application/widgets/pokemon_list.dart';
import 'package:cmu_fondue/data/repositories/pokemon_repo_impl.dart';
import 'package:cmu_fondue/domain/entities/pokemon_entity.dart';
import 'package:cmu_fondue/domain/usecases/get_pokemon_info.dart';
import 'package:flutter/material.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  static const _featuredIds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  late final GetPokemonInfoUseCase _getPokemonInfo;
  late Future<List<PokemonInfo>> _pokemonFuture;

  @override
  void initState() {
    super.initState();
    _getPokemonInfo = GetPokemonInfoUseCase(PokemonRepoImpl());
    _pokemonFuture = _fetchPokemon();
  }

  Future<List<PokemonInfo>> _fetchPokemon() {
    return Future.wait(_featuredIds.map(_getPokemonInfo.call));
  }

  void _reload() {
    setState(() {
      _pokemonFuture = _fetchPokemon();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Pokedex Sample')),
      body: FutureBuilder<List<PokemonInfo>>(
        future: _pokemonFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Something went wrong',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _reload,
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              ),
            );
          }

          final pokemon = snapshot.data ?? [];
          if (pokemon.isEmpty) {
            return const Center(child: Text('No Pokemon available right now.'));
          }

          return PokemonList(pokemon: pokemon);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _reload,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
