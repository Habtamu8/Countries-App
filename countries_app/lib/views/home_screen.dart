// screens/home_screen.dart
import 'package:countries_app/blocs/country_bloc.dart' show CountryBloc;
import 'package:countries_app/blocs/country_event.dart' show FetchCountries;
import 'package:countries_app/blocs/country_state.dart';
import 'package:countries_app/repository/country_repository.dart';
import 'package:countries_app/views/country_shimmer.dart';
import 'package:countries_app/views/country_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CountryBloc(CountryRepository())..add(FetchCountries()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Countries')),
        body: BlocBuilder<CountryBloc, CountryState>(
          builder: (context, state) {
            if (state is CountryLoading) {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (_, __) => const CountryShimmer(),
              );
            } else if (state is CountryLoaded) {
              return ListView.builder(
                itemCount: state.countries.length,
                itemBuilder: (_, index) {
                  final country = state.countries[index];
                  return CountryTile(country: country);
                },
              );
            } else if (state is CountryError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

// Shimmer Widget
