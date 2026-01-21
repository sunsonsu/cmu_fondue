class PokemonInfo {
  final int id;
  final String name;
  final String type;
  final String spriteUrl;

  const PokemonInfo({
    required this.id,
    required this.name,
    required this.type,
    required this.spriteUrl,
  });

  factory PokemonInfo.fromJson(Map<String, dynamic> json) {
    final types = (json['types'] as List<dynamic>?) ?? const [];
    final sprites = json['sprites'] as Map<String, dynamic>?;
    final otherSprites = sprites?['other'] as Map<String, dynamic>?;
    final officialArtwork =
        otherSprites?['official-artwork'] as Map<String, dynamic>?;

    final fallbackSprite =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${json['id']}.png';

    return PokemonInfo(
      id: json['id'] as int,
      name: json['name'] as String,
      type: () {
        if (types.isEmpty) {
          return 'unknown';
        }
        final typeWrapper = types.first as Map<String, dynamic>;
        final typeMap = typeWrapper['type'] as Map<String, dynamic>?;
        return typeMap?['name'] as String? ?? 'unknown';
      }(),
      spriteUrl:
          (officialArtwork?['front_default'] as String?) ??
          (sprites?['front_default'] as String?) ??
          fallbackSprite,
    );
  }
}
