import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../presentation/pages/home_page/page_details.dart';
import '../specific/specific_model.dart';

homeShimmerField(List<Pins> pins, List<Pins> pins2, context) {
  var width = MediaQuery.of(context).size.width;
  return Shimmer.fromColors(
    baseColor: CupertinoColors.systemGrey,
    highlightColor: Colors.white,
    child: MasonryGridView.builder(
      gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: width <= 550
              ? 2
              : width <= 750 && width > 550
                  ? 3
                  : width > 750 && width <= 950
                      ? 4
                      : 4),
      itemBuilder: (context, index) {
        final pin = pins[index];
        final pin2 = pins2[index];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
              child: OpenContainer(
                  closedColor: CupertinoColors.darkBackgroundGray,
                  closedElevation: 0.0,
                  closedBuilder: (context, actions) {
                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(100, 20, 31, 33)),
                            child: Image.network(
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes
                                                ?.toDouble() !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                                .toDouble()
                                        : null);
                              },
                              pin.image ?? "Null image",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: pin.heights! * 0.06,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(pin.name ?? "",
                                style: const TextStyle(
                                    color: CupertinoColors.white),
                                overflow: pin.name!.length >= 4
                                    ? TextOverflow.ellipsis
                                    : TextOverflow.visible),
                            IconButton(
                                onPressed: () async {
                                  await Share.share("https://github.com/",
                                      subject: "Github Link");
                                },
                                icon: const Icon(Icons.more_horiz,
                                    color: CupertinoColors.white))
                          ],
                        ),
                      ],
                    );
                  },
                  openBuilder: (context, actions) {
                    return PageDetails(pins: pin);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
              child: OpenContainer(
                  closedColor: CupertinoColors.darkBackgroundGray,
                  closedElevation: 0.0,
                  closedBuilder: (context, actions) {
                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(100, 20, 31, 33)),
                            child: Image.network(
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes
                                                ?.toDouble() !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                                .toDouble()
                                        : null);
                              },
                              pin2.image ?? "Null image",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: pin2.heights! * 0.06,
                              filterQuality: FilterQuality.high,
                            ),
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
                              child: Text(pin2.name ?? "",
                                  style: const TextStyle(
                                      color: CupertinoColors.white),
                                  overflow: pin2.name!.length >= 4
                                      ? TextOverflow.ellipsis
                                      : TextOverflow.visible),
                            ),
                            IconButton(
                                onPressed: () async {
                                  await Share.share("https://github.com/",
                                      subject: "Github Link");
                                },
                                icon: const Icon(Icons.more_horiz,
                                    color: CupertinoColors.white))
                          ],
                        ),
                      ],
                    );
                  },
                  openBuilder: (context, actions) {
                    return PageDetails(pins: pin2);
                  }),
            ),
          ],
        );
      },
      itemCount: pins.length,
    ),
  );
}
