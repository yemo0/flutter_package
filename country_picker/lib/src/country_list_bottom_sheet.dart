import 'package:flutter/material.dart';

import 'country_code_model.dart';
import 'country_list_view.dart';

void showCountryListBottomSheet({required BuildContext context, required Function(CountryCodeModel country) onSelect}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    builder: (context) {
      return CountryListView(
        onSelect: onSelect,
      );
    },
  );
}
