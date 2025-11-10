import 'package:countries_app/blocs/favorites_bloc.dart' show FavoritesBloc;
import 'package:countries_app/blocs/favorites_state.dart' show FavoritesState, FavoritesLoaded;
import 'package:countries_app/views/country_tile_widget.dart' show CountryTile;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoaded && state.favorites.isNotEmpty) {
          return ListView.builder(
            itemCount: state.favorites.length,
            itemBuilder: (_, index) => CountryTile(country: state.favorites[index]),
          );
        }

        return const Center(child: Text('No favorites yet'));
      },
    );
  }
}