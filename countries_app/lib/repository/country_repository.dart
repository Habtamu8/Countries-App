import 'package:countries_app/models/country_model.dart';
import 'package:dio/dio.dart';


class CountryRepository {
  final Dio _dio = Dio();

  Future<List<Country>> fetchCountries() async {
    try {
      final response = await _dio.get('https://restcountries.com/v3.1/all?fields=name,flags,population,cca2');
      List<Country> countries = (response.data as List)
          .map((json) => Country.fromJson(json))
          .toList();
      return countries;
    } catch (e) {
      throw Exception('Failed to load countries');
    }
  }
}
