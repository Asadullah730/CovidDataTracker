class AppUrl {
  // base url
  static const String baseUrl = 'https://disease.sh/v3/covid-19/';

  // fetch the Covid Data
  static const String worldStateApi = '${baseUrl}all/';
  static const String countryStateApi = '${baseUrl}countries/';
}
