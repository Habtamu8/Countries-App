

import 'package:countries_app/models/country_model.dart' show Country;

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Country> favorites;

  FavoritesLoaded(this.favorites);

  bool contains(Country country) {
    return favorites.any((c) => c.name == country.name);
  }
}
