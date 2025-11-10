// models/country_model.dart
class Country {
  final String name;
  final String flagUrl;
  final int population;

  Country({
   required this.name,
   required this.flagUrl, 
   required this.population});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] != null && json['name']['common'] != null ? json['name']['common'] : '',
      flagUrl: json['flags'] != null && json['flags']['png'] != null ? json['flags']['png'] : '',
      population: json['population'] ?? 0,
    );
  }
}
