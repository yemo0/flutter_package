import 'package:flutter/material.dart';

import 'src/country_code_model.dart';
import 'src/country_list_bottom_sheet.dart';

export 'src/country.dart';

void showCountryPicker({required BuildContext context, required Function(CountryCodeModel country) onSelect}) {
  showCountryListBottomSheet(
    context: context,
    onSelect: onSelect,
  );
}
