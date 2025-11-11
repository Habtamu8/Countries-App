// blocs/favorites/favorites_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesLoaded(const [])) {
    on<AddFavorite>(_onAdd);
    on<RemoveFavorite>(_onRemove);
  }

  void _onAdd(AddFavorite event, Emitter<FavoritesState> emit) {
    final current = state as FavoritesLoaded;
    if (current.favorites.contains(event.country)) return; // avoid duplicates
    emit(FavoritesLoaded([...current.favorites, event.country]));
  }

  void _onRemove(RemoveFavorite event, Emitter<FavoritesState> emit) {
    final current = state as FavoritesLoaded;
    emit(FavoritesLoaded(
      current.favorites.where((c) => c != event.country).toList(),
    ));
  }
}
