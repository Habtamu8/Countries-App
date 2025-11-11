import 'package:countries_app/blocs/country_bloc.dart' show CountryBloc;
import 'package:countries_app/blocs/country_event.dart' show FetchCountries;
import 'package:countries_app/blocs/favorites_bloc.dart' show FavoritesBloc;
import 'package:countries_app/repository/country_repository.dart'
    show CountryRepository;
import 'package:countries_app/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              CountryBloc(CountryRepository())..add(FetchCountries()),
        ),
        BlocProvider(create: (_) => FavoritesBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Countries App',
      themeMode: ThemeMode.system,
      // Light Theme
      theme: ThemeData.light().copyWith(primaryColor: Colors.blue),

      darkTheme: ThemeData.dark().copyWith(primaryColor: const Color.fromARGB(255, 139, 153, 164)),
      home: HomeScreen(),
    );
  }
}
