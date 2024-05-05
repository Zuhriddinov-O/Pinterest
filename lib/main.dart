import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinterest/presentation/pages/main_page.dart';
import 'package:pinterest/presentation/view_model/home_vm.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => DetailedPageViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel2())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: CupertinoColors.darkBackgroundGray,
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              backgroundColor: Colors.transparent,
            )),
        home: const MainPage(),
      ),
    );
  }
}
