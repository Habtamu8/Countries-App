// blocs/favorites/favorites_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'favorites_event.dart';
import 'favorites_state.dart';
import '../../models/country_model.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddFavorite>(_onAddFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
  }

  Future<void> _onLoadFavorites(LoadFavorites event, Emitter<FavoritesState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final savedNames = prefs.getStringList('favorites') ?? [];
    emit(FavoritesLoaded(savedNames.map((name) => Country(name: name, flag: '', population: 0)).toList()));
  }

  Future<void> _onAddFavorite(AddFavorite event, Emitter<FavoritesState> emit) async {
    if (state is FavoritesLoaded) {
      final current = (state as FavoritesLoaded).favorites;
      if (!current.any((c) => c.name == event.country.name)) {
        final updated = List<Country>.from(current)..add(event.country);
        emit(FavoritesLoaded(updated));
        final prefs = await SharedPreferences.getInstance();
        await prefs.setStringList('favorites', updated.map((c) => c.name).toList());
      }
    }
  }

  Future<void> _onRemoveFavorite(RemoveFavorite event, Emitter<FavoritesState> emit) async {
    if (state is FavoritesLoaded) {
      final current = (state as FavoritesLoaded).favorites;
      final updated = current.where((c) => c.name != event.country.name).toList();
      emit(FavoritesLoaded(updated));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favorites', updated.map((c) => c.name).toList());
    }
  }
}
