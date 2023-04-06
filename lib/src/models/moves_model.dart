class MovesModel {
  final String name;
  final String url;

  MovesModel({required this.name, required this.url});

  factory MovesModel.fromJson(Map<String, dynamic> json) => MovesModel(
        name: json['move']['name'] ?? '',
        url: json['move']['url'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
