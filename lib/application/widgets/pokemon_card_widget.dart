import 'package:cmu_fondue/domain/entities/pokemon_entity.dart';
import 'package:flutter/material.dart';

class PokemonIconWidget extends StatelessWidget {
  const PokemonIconWidget({super.key, required this.info});

  final PokemonInfo info;

  String get _displayName {
    if (info.name.isEmpty) {
      return 'Unknown';
    }
    return info.name[0].toUpperCase() + info.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chipColor = theme.colorScheme.primaryContainer;
    final chipOnColor = theme.colorScheme.onPrimaryContainer;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.network(
                info.spriteUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.image_not_supported_outlined,
                  color: theme.colorScheme.error,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _displayName,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(info.type.toUpperCase()),
              backgroundColor: chipColor,
              labelStyle: theme.textTheme.labelSmall?.copyWith(
                color: chipOnColor,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
