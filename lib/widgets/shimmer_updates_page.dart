import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../presentation/pages/home_page/page_details.dart';
import '../presentation/view_model/home_vm.dart';
import '../specific/specific_model.dart';

shimmerUpdates(context) {
  final mediaWidth = MediaQuery.of(context).size.width;
  final mediaHeight = MediaQuery.of(context).size.height;
  final List<Pins> totalImages = [];
  final list1 = Provider.of<HomeViewModel>(context, listen: true).pinList;
  final list2 = Provider.of<HomeViewModel2>(context, listen: true).pinList2;
  totalImages.addAll(list1);
  totalImages.addAll(list2);
  final List<int> updatedMinutesList = [];
  return Shimmer.fromColors(
    baseColor: CupertinoColors.systemGrey,
    highlightColor: Colors.white,
    child:  GridView.builder(
      itemCount: totalImages.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisExtent: 200),
      itemBuilder: (context, index1) {
        return SizedBox(
          height: 216,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: GridView.builder(
                      itemCount: mediaWidth <= 750 ? 3 : 4,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: mediaHeight * 0.3, crossAxisCount: mediaWidth <= 750 ? 3 : 4),
                      itemBuilder: (context, index2) {
                        List<Pins> totalImage = totalImages.toSet().toList();
                        totalImage.shuffle();

                        final Pins pin = totalImage[index1];

                        final halfLength = pin.updatedAt!.length / 2;
                        final subStringed = pin.updatedAt!.substring(halfLength + 1 as int, 19);
                        final updatedMinutes = int.parse(subStringed.substring(3, 5)); //
                        updatedMinutesList.add(updatedMinutes); //
                        Set<int> set = updatedMinutesList.toSet();
                        List<int> result = set.toList();
                        result.sort((a, b) => b.compareTo(a)); //

                        return OpenContainer(
                          closedShape: const RoundedRectangleBorder(),
                          closedColor: CupertinoColors.darkBackgroundGray,
                          closedElevation: 0.0,
                          closedBuilder: (context, actions) {
                            return Image.network(
                              pin.image ?? "Null image",
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.high,
                            );
                          },
                          openBuilder: (context, actions) {
                            return PageDetails(pins: pin);
                          },
                        );
                      },
                    ),
                  ),
                ),
                // for (int i = 0; i < ideaList.length; i++)
                //   Text(ideaList[index1], style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        );
      },
    ),
  );
}
