


import 'package:countries_app/models/country_model.dart';

abstract class FavoritesEvent {}

class LoadFavorites extends FavoritesEvent {}

class AddFavorite extends FavoritesEvent {
  final Country country;
  AddFavorite(this.country);
}

class RemoveFavorite extends FavoritesEvent {
  final Country country;
  RemoveFavorite(this.country);
}
