// blocs/country/country_bloc.dart
import 'package:countries_app/repository/country_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'country_event.dart';
import 'country_state.dart';


class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountryRepository repository;

  CountryBloc(this.repository) : super(CountryInitial()) {
    on<FetchCountries>((event, emit) async {
      emit(CountryLoading());
      try {
        final countries = await repository.fetchCountries();
        emit(CountryLoaded(countries));
      } catch (e) {
        emit(CountryError('Failed to fetch countries'));
      }
    });
  }
}
