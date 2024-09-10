# theme_provider
Dark mode and Color Management

## Getting Started 
```yaml
theme_provider:
    git: 
      url: https://github.com/yemo0/flutter_package.git
      path: theme_provider
      ref: main
```

### init
**MyApp extends `ConsumerWidget`**
Add the following to MaterialApp
```dart
theme: lightMode,
darkTheme: darkMode,
themeMode: ref.watch(themeProvider),
```
example: 
```dart
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ref.watch(themeProvider),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}
```

### Using Components
- DarkModeButton()
  - dark mode toggle button