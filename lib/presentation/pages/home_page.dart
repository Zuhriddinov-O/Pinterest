import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pinterest/presentation/view_model/home_vm.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
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

  String text = "";

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
        body: _successField(list, followBool),
      ),
    );
  }

  bool followBool = false;

  _successField(List<Pins> pins, followBool) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: pins.length,
      itemBuilder: (context, index) {
        final pin = pins[index];
        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 25),
          child: OpenContainer(
              closedColor: CupertinoColors.darkBackgroundGray,
              closedElevation: 0.0,
              closedBuilder: (context, actions) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        loadingBuilder:
                            (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes?.toDouble() != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!.toDouble()
                                  : null);
                        },
                        pin.image ?? "Null image",
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: pin.heights! * 0.06,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(pin.name ?? "",
                            style: const TextStyle(color: CupertinoColors.white),
                            overflow: TextOverflow.visible),
                        IconButton(
                            onPressed: () async {
                              await Share.share("https://github.com/", subject: "Github Link");
                            },
                            icon: const Icon(Icons.more_horiz, color: CupertinoColors.white))
                      ],
                    ),
                  ],
                );
              },
              openBuilder: (context, actions) {
                final slug = pin.slug?.replaceAll("-", " ");
                return Container(
                  width: width,
                  height: double.infinity,
                  decoration: const BoxDecoration(color: CupertinoColors.darkBackgroundGray),
                  child: Stack(
                    children: [
                      ListView(
                        children: [
                          Image.network(pin.image ?? "",
                              height: height,
                              width: width,
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.high),
                          Row(
                            children: [
                              Text(pin.user?.username ?? "",
                                  style: const TextStyle(color: Colors.white, fontSize: 25)),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        followBool == true ? Colors.red : Colors.blue)),
                                child: Text(followBool == true ? "followed" : "follow"),
                                onPressed: () {
                                  setState(() => followBool = !followBool);
                                  print(followBool);
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      AppBar(
                        forceMaterialTransparency: true,
                        leading: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(CupertinoIcons.back, color: CupertinoColors.white),
                        ),
                        actions: [
                          IconButton(
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) => ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                  child: BottomSheet(
                                      backgroundColor: CupertinoColors.systemGrey,
                                      enableDrag: true,
                                      onClosing: () {},
                                      builder: (context) {
                                        return SizedBox(
                                          height: height * 0.3,
                                          width: width,
                                          child: const Text("Container"),
                                        );
                                      }),
                                ),
                              );
                            },
                            icon: const Icon(Icons.more_horiz, color: CupertinoColors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        );
      },
    );
  }
}
