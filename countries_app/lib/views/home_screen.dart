// screens/home_screen.dart
import 'package:countries_app/blocs/country_bloc.dart' show CountryBloc;
import 'package:countries_app/blocs/country_state.dart';
import 'package:countries_app/views/country_shimmer.dart';
import 'package:countries_app/views/country_tile_widget.dart';
import 'package:countries_app/views/favorites_screen.dart' show FavoritesScreen;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
        appBar: AppBar(
          title: const Text('Countries'),
          bottom: currentIndex == 0 // show search only in home tab
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(56),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search countries...',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() => searchQuery = value.toLowerCase());
                      },
                    ),
                  ),
                )
              : null,
        ),

        body: currentIndex == 0 ? _buildCountriesList() : const FavoritesScreen(),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (i) => setState(() => currentIndex = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Countries'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          ],
        ),
      );
  
  }

  Widget _buildCountriesList() {
    return BlocBuilder<CountryBloc, CountryState>(
      builder: (context, state) {
        if (state is CountryLoading) {
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (_, __) => const CountryShimmer(),
          );
        } else if (state is CountryLoaded) {
          final filtered = state.countries
              .where((c) => c.name.toLowerCase().contains(searchQuery))
              .toList();

          return ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (_, index) => CountryTile(country: filtered[index]),
          );
        } else if (state is CountryError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
