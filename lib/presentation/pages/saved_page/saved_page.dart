import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinterest/presentation/pages/main_page/main_page.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      body: ListView(
        children: [
          ListTile(
            title: SizedBox(
              height: mediaHeight * 0.041,
              child: SearchBar(
                leading: Padding(
                  padding: EdgeInsets.only(left: mediaWidth * 0.01),
                  child: const Icon(CupertinoIcons.search),
                ),
                hintText: "Search your Pins",
                backgroundColor: MaterialStatePropertyAll(Colors.grey[600]),
                overlayColor: const MaterialStatePropertyAll(
                  CupertinoColors.darkBackgroundGray,
                ),
              ),
            ),
            trailing: Padding(
              padding: EdgeInsets.only(right: mediaWidth * 0.01),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(CupertinoPageRoute(builder: (context) => const MainPage()));
                  },
                  icon: const Icon(CupertinoIcons.add, color: CupertinoColors.white)),
            ),
          )
        ],
      ),
    );
  }
}
