import 'package:country_picker/src/country_code_model.dart';
import 'package:country_picker/src/utils.dart';
import 'res/country_codes.dart';

class CountryPicker {
  static List<CountryCodeModel> getCountryCodesList() {
    List<CountryCodeModel> countryCodesList = countryCodes.map((json) => CountryCodeModel.fromJson(json)).toList();
    return countryCodesList;
  }

  static List<CountryCodeModel> filterCountryCodesList(String query) {
    final lowerCaseQuery = query.toLowerCase();
    List<CountryCodeModel> countryCodesList = getCountryCodesList();
    return countryCodesList.where((element) {
      return element.displayName != null && element.displayName!.toLowerCase().contains(lowerCaseQuery);
    }).toList();
  }

  static String getFlagEmoji(String code) {
    return Utils.countryCodeToEmoji(code);
  }
}
