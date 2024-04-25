import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest/domain/data/model/model.dart';

import '../../domain/data/repository/repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PinPhotos? pints;
  final _api = DioRepositoryImpl();

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
    );
  }

  _successField(List<Urls> pins) {
    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: pins.length,
      itemBuilder: (context, index) {
        final pin = pins[index];
        return SizedBox(
          child: Center(
              child:
                  Text(pin.full ?? "", style: const TextStyle(color: CupertinoColors.white))),
        );
      },
    );
  }
}
