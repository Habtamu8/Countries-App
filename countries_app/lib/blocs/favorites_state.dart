import '../../models/country_model.dart';

abstract class FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Country> favorites;

  FavoritesLoaded(this.favorites);

  bool contains(Country country) => favorites.contains(country);
}


