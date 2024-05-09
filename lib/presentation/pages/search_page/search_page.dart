import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest/presentation/pages/home_page/home_page_details.dart';
import 'package:pinterest/presentation/view_model/home_vm.dart';
import 'package:pinterest/widgets/search_page_shimmer.dart';
import 'package:provider/provider.dart';

import '../../../specific/specific_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading = false;

  @override
  void initState() {
    foundProducts = productList;
    Provider.of<HomeViewModel>(context, listen: false).fetchPhotoList(3);
    Provider.of<HomeViewModel2>(context, listen: false).fetchPhotoList2(4);
    Future.delayed(const Duration(seconds: 3)).then((value) {
      isLoading = true;
    });
    super.initState();
  }

  List<Pins> productList = [];
  List<Pins> foundProducts = [];

  void runFilter(String query) {
    List<Pins> result = [];
    if (query.isEmpty) {
      result = productList;
    } else {
      result = productList
          .where((element) => element.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      foundProducts = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final photos = Provider.of<HomeViewModel>(context, listen: true).pinList;
    final photos2 = Provider.of<HomeViewModel2>(context, listen: true).pinList2;

    for (int index = 0; index < photos.length; index++) {
      productList.add(photos[index]);
    }
    for (int index2 = 0; index2 < photos2.length; index2++) {
      productList.add(photos2[index2]);
    }
    print(productList);

    void runFilter(String query) {
      List<Pins> result = [];
      if (query.isEmpty) {
        result = productList;
      } else {
        result = productList
            .where((element) => element.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      setState(() {
        foundProducts = result;
      });
    }

    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: mediaHeight * 0.06,
          child: SearchBar(
            onChanged: (value) {
              setState(() {
                runFilter(value);
              });
            },
            leading: Padding(
              padding: EdgeInsets.only(left: mediaWidth * 0.01),
              child: const Icon(CupertinoIcons.search, color: Colors.white38),
            ),
            textStyle: const MaterialStatePropertyAll(TextStyle(color: Colors.white54)),
            hintText: "Search for ideas",
            backgroundColor: const MaterialStatePropertyAll(CupertinoColors.darkBackgroundGray),
            overlayColor: const MaterialStatePropertyAll(
              CupertinoColors.darkBackgroundGray,
            ),
            trailing: [
              Padding(
                padding: EdgeInsets.only(right: mediaWidth * 0.01),
                child: const Icon(
                  CupertinoIcons.photo_camera_solid,
                  color: Colors.white38,
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: CupertinoColors.darkBackgroundGray,
      body: isLoading == false
          ? searchPageShimmer(productList, context)
          : Column(
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
}
