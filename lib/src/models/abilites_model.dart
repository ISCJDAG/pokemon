class AbilitiesModel {
  final String name;
  final String url;

  AbilitiesModel({required this.name, required this.url});

  factory AbilitiesModel.fromJson(Map<String, dynamic> json) => AbilitiesModel(
        name: json['ability']['name'] ?? '',
        url: json['ability']['url'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
