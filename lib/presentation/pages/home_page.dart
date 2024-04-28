import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pinterest/presentation/view_model/home_vm.dart';
import 'package:provider/provider.dart';

import '../../specific/specific_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<HomeViewModel>(context, listen: false).fetchAnimeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<HomeViewModel>(context).pinList;
    return LiquidPullToRefresh(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      color: Colors.white,
      showChildOpacityTransition: true,
      springAnimationDurationInMilliseconds: 600,
      onRefresh: () async {
        setState(() {
          list;
        });
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("All", style: TextStyle(color: CupertinoColors.white))),
        backgroundColor: CupertinoColors.darkBackgroundGray,
        body: _successField(list),
      ),
    );
  }

  _successField(List<Pins> pins) {
    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: pins.length,
      itemBuilder: (context, index) {
        final pin = pins[index];
        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 25),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: OpenContainer(
                closedColor: CupertinoColors.darkBackgroundGray,
                closedElevation: 0.0,
                closedBuilder: (context, actions) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        pin.image ?? "Null image",
                        fit: BoxFit.fill,
                        width: double.infinity,
                        filterQuality: FilterQuality.high,
                      ),
                    ],
                  );
                },
                openBuilder: (context, actions) {
                  return Scaffold(
                    backgroundColor: CupertinoColors.darkBackgroundGray,
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            pin.image ?? "www.pornhub.com",
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 2,
                            filterQuality: FilterQuality.high,
                          ),
                          Text(pin.firstName ?? "",
                              style: const TextStyle(color: Colors.white, fontSize: 25)),
                          Text(pin.assetType ?? "",
                              style: const TextStyle(color: Colors.white, fontSize: 25)),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
