// models/country_model.dart
class Country {
  final String name;
  final String flag;
  final int population;

  Country({required this.name, required this.flag, required this.population});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] != null && json['name']['common'] != null
          ? json['name']['common']
          : '',
      flag: json['flags'] != null && json['flags']['png'] != null
          ? json['flags']['png']
          : '',
      population: json['population'] ?? 0,
    );
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Country && other.name == name);

  @override
  int get hashCode => name.hashCode;
}
