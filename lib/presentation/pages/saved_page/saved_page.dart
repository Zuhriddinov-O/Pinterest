import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinterest/widgets/search_bar.dart';

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
          searchBar(mediaHeight, mediaWidth, context),

        ],
      ),
    );
  }
}
