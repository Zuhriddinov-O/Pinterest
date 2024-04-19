import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinterest/presentation/main_page.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: CupertinoColors.darkBackgroundGray,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.transparent,
          )),
      home: const MainPage(),
    );
  }
}
