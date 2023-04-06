class PokemonModel {
  final String name;
  final String url;

  PokemonModel({
    required this.name,
    required this.url,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) => PokemonModel(
        name: json['name'] ?? '',
        url: json['url'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
