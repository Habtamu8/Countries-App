// widgets/country_tile.dart
import 'package:countries_app/blocs/favorites_bloc.dart' show FavoritesBloc;
import 'package:countries_app/blocs/favorites_event.dart' show RemoveFavorite, AddFavorite;
import 'package:countries_app/blocs/favorites_state.dart' show FavoritesState, FavoritesLoaded;
import 'package:countries_app/models/country_model.dart';
import 'package:countries_app/views/country_detail_screen.dart' show CountryDetailScreen;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;

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
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        bool isFav = false;
        if (state is FavoritesLoaded) {
          isFav = state.contains(country);
        }
         

        return ListTile(
          leading: Image.network(
            country.flag,
            width: 50,
            height: 30,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.flag),
          ),
          title: Text(country.name),
          subtitle: Text('Population: $formattedPopulation'),
          trailing: IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite),
            onPressed: () {
              if (isFav) {
                context.read<FavoritesBloc>().add(RemoveFavorite(country));
              } else {
                context.read<FavoritesBloc>().add(AddFavorite(country));
              }
            },
          ),
         onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => CountryDetailScreen(country: country),
              ),
            );
           },
        );
      },
    );
  }
}
