import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/ingredient_list_page.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '買い出しアプリ',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.orange, foregroundColor: Colors.white),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: IngredientListPage(),
    );
  }
}
