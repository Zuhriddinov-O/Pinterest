import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../notification_page/notification_page.dart';
import '../saved_page/saved_page.dart';
import '../search_page/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with ChangeNotifier {
  List pages = const [
    SavedPage(),
    SearchPage(),
    // NotificationPage(),
    // HomePage(),
  ];
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: CupertinoColors.white,
        unselectedItemColor: CupertinoColors.systemGrey,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        showUnselectedLabels: true,
        currentIndex: pageIndex,
        backgroundColor: CupertinoColors.darkBackgroundGray,
        useLegacyColorScheme: true,
        iconSize: 21,
        selectedIconTheme: const IconThemeData(size: 25),
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        selectedFontSize: 13,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              backgroundColor: CupertinoColors.darkBackgroundGray, icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
              backgroundColor: CupertinoColors.darkBackgroundGray, icon: Icon(CupertinoIcons.search), label: "Search"),
          BottomNavigationBarItem(
              backgroundColor: CupertinoColors.darkBackgroundGray,
              icon: Icon(CupertinoIcons.chat_bubble_text),
              label: "Notifica..."),
          BottomNavigationBarItem(
              backgroundColor: CupertinoColors.darkBackgroundGray, icon: Icon(Icons.person), label: "Saved"),
        ],
      ),
    );
  }
}
