import 'package:flutter/material.dart';

import 'country_code_model.dart';
import 'country_list_view.dart';

void showCountryListBottomSheet({required BuildContext context, required Function(CountryCodeModel country) onSelect}) {
  final statusBarHeight = MediaQuery.of(context).padding.top;
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    isScrollControlled: true,
    builder: (context) {
      return SizedBox(
        height: MediaQuery.sizeOf(context).height - (statusBarHeight + (kToolbarHeight / 1.5)),
        child: CountryListView(
          onSelect: onSelect,
        ),
      );
    },
  );
}
