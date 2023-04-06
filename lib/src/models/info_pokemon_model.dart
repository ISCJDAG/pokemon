import 'abilites_model.dart';
import 'moves_model.dart';

class InfoPokemonModel {
  final int id;
  final String name;
  final List<MovesModel> moves;
  final List<AbilitiesModel> abilities;

  InfoPokemonModel({
    required this.id,
    required this.name,
    required this.moves,
    required this.abilities,
  });

  String get imageUrl {
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
  }

  factory InfoPokemonModel.fromJson(Map<String, dynamic> json) =>
      InfoPokemonModel(
        id: json['id'],
        name: json['name'],
        moves: List<MovesModel>.from(
            json['moves']?.map((x) => MovesModel.fromJson(x))),
        abilities: List<AbilitiesModel>.from(
            json['abilities']?.map((x) => AbilitiesModel.fromJson(x))),
      );
}
