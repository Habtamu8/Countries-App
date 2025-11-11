import 'package:countries_app/blocs/favorites_bloc.dart' show FavoritesBloc;
import 'package:countries_app/blocs/favorites_event.dart' show RemoveFavorite, AddFavorite;
import 'package:countries_app/blocs/favorites_state.dart' show FavoritesState, FavoritesLoaded;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/country_model.dart';


class CountryDetailScreen extends StatelessWidget {
  final Country country;
  const CountryDetailScreen({super.key, required this.country});

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
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
        actions: [
          BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              final isFavorite = state is FavoritesLoaded && state.contains(country);
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  if (isFavorite) {
                    context.read<FavoritesBloc>().add(RemoveFavorite(country));
                  } else {
                    context.read<FavoritesBloc>().add(AddFavorite(country));
                  }
                },
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Image.network(
              country.flag,
              width: 200,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.flag, size: 80),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            country.name,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            "Population: $formattedPopulation",
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          if (country.population != null)
            Text(
              "Region: ${country.population}",
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          if (country.name != null)
            Text(
              "Subregion: ${country.name}",
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
