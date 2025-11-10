// widgets/country_tile.dart
import 'package:countries_app/models/country_model.dart';
import 'package:flutter/material.dart';


class CountryTile extends StatelessWidget {
  final Country country;

  const CountryTile({super.key, required this.country});

  String get formattedPopulation {
    if (country.population >= 1000000) {
      return '${(country.population / 1000000).toStringAsFixed(1)}M';
    } else if (country.population >= 1000) {
      return '${(country.population / 1000).toStringAsFixed(1)}K';
    } else {
      return country.population.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        country.flag,
        width: 50,
        height: 30,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.flag),
      ),
      title: Text(country.name),
      subtitle: Text('Population: $formattedPopulation'),
      onTap: () {
        // Navigate to country details screen later
      },
    );
  }
}
