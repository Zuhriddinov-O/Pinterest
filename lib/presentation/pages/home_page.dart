import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pinterest/presentation/pages/home_page_details.dart';
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
    Provider.of<HomeViewModel>(context, listen: false).fetchPhotoList(1);
    Provider.of<HomeViewModel2>(context, listen: false).fetchPhotoList2(2);
    super.initState();
  }

  String text = "";
  bool followBool = false;

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<HomeViewModel>(context).pinList;
    final list2 = Provider.of<HomeViewModel2>(context).pinList2;

    return LiquidPullToRefresh(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      color: Colors.white,
      showChildOpacityTransition: true,
      springAnimationDurationInMilliseconds: 600,
      onRefresh: () async {
        setState(() {
          list;
          list2;
        });
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("All", style: TextStyle(color: CupertinoColors.white))),
        backgroundColor: CupertinoColors.darkBackgroundGray,
        body: Column(
          children: [
            _successField(list, followBool),
          ],
        ),
      ),
    );
  }

  _successField(List<Pins> pins, followBool) {
    // var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      child: MasonryGridView.builder(
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: width <= 550
                ? 2
                : true && width <= 750 && width > 550
                    ? 3
                    : width > 750 && width <= 950
                        ? 4
                        : 4),
        itemBuilder: (context, index) {
          final pin = pins[index];
          return Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 25),
            child: OpenContainer(
                closedColor: CupertinoColors.darkBackgroundGray,
                closedElevation: 0.0,
                closedBuilder: (context, actions) {
                  return Column(
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
                          SizedBox(
                            width: width <= 550
                                ? width / 2.5
                                : true && width <= 750 && width > 550
                                    ? width / 4.3
                                    : width > 750 && width <= 950
                                        ? width * 0.18
                                        : width * 0.18,
                            child: Text(pin.name ?? "",
                                style: const TextStyle(color: CupertinoColors.white),
                                overflow: pin.name!.length >= 4
                                    ? TextOverflow.ellipsis
                                    : TextOverflow.visible),
                          ),
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
                  return HomePageDetails(pins: pin);
                }),
          );
        },
        itemCount: pins.length,
      ),
    );
  }
}
