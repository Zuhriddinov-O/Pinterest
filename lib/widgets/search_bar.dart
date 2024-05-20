import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../presentation/pages/main_page/main_page.dart';

searchBar(double mediaHeight,double mediaWidth,context){
  return ListTile(
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
  );
}