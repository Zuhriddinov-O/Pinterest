import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      body: ListView(
        children: [
          Padding(
            padding:EdgeInsets.symmetric(horizontal:mediaWidth*0.04),
            child: SizedBox(
              height: mediaHeight * 0.041,
              child: SearchBar(
                leading: Padding(
                  padding: EdgeInsets.only(left: mediaWidth * 0.01),
                  child: const Icon(CupertinoIcons.search),
                ),
                hintText: "Search for ideas",
                backgroundColor: MaterialStatePropertyAll(Colors.grey[600]),
                overlayColor: const MaterialStatePropertyAll(
                  CupertinoColors.darkBackgroundGray,
                ),
                trailing: [
                  Padding(
                    padding: EdgeInsets.only(right: mediaWidth * 0.01),
                    child: const Icon(CupertinoIcons.photo_camera_solid),
                  )
                ],
              ),
            ),
          ),
          const Text("SearchPage")
        ],
      ),
    );
  }
}
