## country picker

select a country from a list of countries.

[some code from country_picker](https://pub.dev/packages/country_picker)

## Getting Started

```yaml
country_picker:
  git:
    url: https://github.com/yemo0/flutter_package.git
    path: country_picker
    ref: main
```

Example:

```dart
showCountryPicker(
  context: context,
  onSelect: (value) {
    print(value.displayName);
  },
);
```

## bug

- Search box height on windows
  - modify TextField contentPadding maybe can fix
- Windows cannot load flag emoji
