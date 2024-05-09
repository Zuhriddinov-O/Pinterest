import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import '../presentation/pages/home_page/home_page_details.dart';
import '../specific/specific_model.dart';

searchPageShimmer(List<Pins> productList, context) {
  final mediaWidth = MediaQuery.of(context).size.width;
  return Shimmer.fromColors(
    baseColor: CupertinoColors.systemGrey,
    highlightColor: Colors.white,
    child: Column(
      children: [
        const Text("Ideas for you",
            style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 23,
                decorationColor: Colors.red,
                decorationStyle: TextDecorationStyle.double)),
        Expanded(
          child: MasonryGridView.builder(
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: mediaWidth <= 550
                  ? 2
                  : true && mediaWidth <= 750 && mediaWidth > 550
                      ? 3
                      : mediaWidth > 750 && mediaWidth <= 950
                          ? 4
                          : 4,
            ),
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) {
              final photo = productList[index];
              print("ffffffffffffffff:${productList[index]}");
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: OpenContainer(
                          closedColor: CupertinoColors.darkBackgroundGray,
                          openColor: CupertinoColors.darkBackgroundGray,
                          closedBuilder: (context, invoke) {
                            return Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(100, 20, 31, 33),
                                  image: DecorationImage(
                                    image: NetworkImage(photo.image ?? ""),
                                    alignment: Alignment.center,
                                    fit: BoxFit.fill,
                                    filterQuality: FilterQuality.high,
                                  )),
                              child: Center(
                                  child: Text(photo.name ?? "",
                                      style: const TextStyle(color: Colors.white))),
                            );
                          },
                          openBuilder: (context, action) {
                            return HomePageDetails(pins: photo);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
