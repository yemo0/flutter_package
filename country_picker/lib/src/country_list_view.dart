import 'package:country_picker/src/utils.dart';
import 'package:flutter/material.dart';

import '../country_picker.dart';
import 'country_code_model.dart';

class CountryListView extends StatefulWidget {
  final Function(CountryCodeModel country) onSelect;
  const CountryListView({super.key, required this.onSelect});

  @override
  State<CountryListView> createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
  late TextEditingController _searchController;
  final countryCodesList = CountryPicker.getCountryCodesList();
  List<CountryCodeModel>? filteredList;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                height: 50.0,
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: TextField(
                    controller: _searchController,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(fontSize: 16.0),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isCollapsed: true,
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 16,
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 30.0),
                      suffixIcon: _searchController.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: cancelSearch,
                              icon: const Icon(
                                Icons.cancel,
                                size: 16,
                              )),
                      hintText: "Search",
                      contentPadding: const EdgeInsets.all(5),
                      filled: true,
                      fillColor: const Color(0xFfbfbfbf),
                    ),
                    onChanged: _searchChanged,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
        ),
        if (filteredList == null)
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                // Skip level 3
                if (countryCodesList[index].level == 3) return const SizedBox.shrink();
                return _listItem(countryCodesList[index]);
              },
              itemCount: countryCodesList.length,
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _listItem(filteredList![index]);
              },
              itemCount: filteredList!.length,
            ),
          )
      ],
    );
  }

  Widget _listItem(CountryCodeModel country) {
    return ListTile(
      onTap: () {
        widget.onSelect(country);
        Navigator.pop(context);
      },
      title: Row(
        children: [
          Text(
            Utils.countryCodeToEmoji(country.iso2Cc ?? ""),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            country.displayNameNoE164Cc ?? "",
            style: const TextStyle(fontSize: 13.0, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
      trailing: Text("+${country.e164Cc}"),
    );
  }

  void cancelSearch() {
    _searchController.clear();
    _searchChanged("");
  }

  void _searchChanged(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredList = null;
      });
      return;
    }
    setState(() {
      filteredList = CountryPicker.filterCountryCodesList(query);
    });
  }
}
