import 'package:cmu_fondue/application/widgets/pokemon_card_widget.dart';
import 'package:cmu_fondue/domain/entities/pokemon_entity.dart';
import 'package:flutter/material.dart';

class PokemonList extends StatelessWidget {
  const PokemonList({super.key, required this.pokemon});

  final List<PokemonInfo> pokemon;

  @override
  Widget build(BuildContext context) {
    if (pokemon.isEmpty) {
      return const Center(child: Text('No Pokemon found.'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: pokemon.length,
      itemBuilder: (context, index) => PokemonIconWidget(info: pokemon[index]),
    );
  }
}
