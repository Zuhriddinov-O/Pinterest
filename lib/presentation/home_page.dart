import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest/data/api/http_api_service.dart';
import 'package:pinterest/model/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PinPhotos? pints;
  final _api = Api.getWallpapers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All",
          style: TextStyle(color: CupertinoColors.white),
        ),
      ),
      backgroundColor: CupertinoColors.darkBackgroundGray,
      body: FutureBuilder(
        future: _api,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            _successField(snapshot.data! as List<PinPhotos>);
          }
          return const Center(
              child: Text("Something is wrong", style: TextStyle(color: CupertinoColors.white)));
        },
      ),
    );
  }

  _successField(List<PinPhotos> pins) {
    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: pins.length,
      itemBuilder: (context, index) {
        final pin = pins[index];
        return SizedBox(
          child: Center(
              child: Text(pin.altDescription ?? "",
                  style: const TextStyle(color: CupertinoColors.white))),
        );
      },
    );
  }
}
