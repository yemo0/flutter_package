import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theme_provider/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ref.watch(themeProvider),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Theme Provider Example'),
        actions: const [
          DarkModeButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(color: Colors.black12)),
                child: ListTile(
                  leading: IconButton(onPressed: () {}, icon: const Icon(Icons.check_box)),
                  title: const Text("This is a Text"),
                  subtitle: const Text("This is a subtitle"),
                )),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(color: Colors.black12)),
              child: ListTile(
                leading: IconButton(onPressed: () {}, icon: const Icon(Icons.check_box)),
                title: const Text("This is a Text"),
                subtitle: const Text("This is a subtitle"),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.all(8),
              child: const Text(
                  "English is a West Germanic language in the Indo-European language family, whose speakers, called Anglophones, originated in early medieval England on the island of Great Britain. The namesake of the language is the Angles, one of the ancient Germanic peoples that migrated to Britain."),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {
                }, child: const Text("Button 1")),
                ElevatedButton(onPressed: () {}, child: const Text("Button 2")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
