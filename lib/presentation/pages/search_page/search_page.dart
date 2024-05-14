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
  bool isFirstTime = true;

  @override
  void initState() {
    Provider.of<HomeViewModel>(context, listen: false).fetchPhotoList(3);
    Provider.of<HomeViewModel2>(context, listen: false).fetchPhotoList2(4);
    super.initState();
  }

  List<Pins> productList = [];
  List<Pins> foundProducts = [];

  void runFilter(String query) {
    if (query.isEmpty) {
      productList.clear();
      productList.addAll(foundProducts);
      setState(() {});
    } else {
      // print('hew');
      final filteredList = foundProducts
          .where((element) =>
              element.firstName!.toLowerCase().contains(query.toLowerCase()) ||
              element.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      // print(filteredList.length);
      productList.clear();
      productList.addAll(filteredList);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      isLoading = true;
      setState(() {});
    });
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;

    if (isFirstTime) {
      final photos = Provider.of<HomeViewModel>(context, listen: true).pinList;
      final photos2 =
          Provider.of<HomeViewModel2>(context, listen: true).pinList2;
      productList.addAll(photos);
      productList.addAll(photos2);

      // foundProducts.addAll(photos);
      foundProducts.addAll(photos2);
      isFirstTime = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: mediaHeight * 0.06,
          child: SearchBar(
            onChanged: (query) => runFilter(query),
            leading: Padding(
              padding: EdgeInsets.only(left: mediaWidth * 0.01),
              child: const Icon(CupertinoIcons.search, color: Colors.white38),
            ),
            textStyle: const MaterialStatePropertyAll(
                TextStyle(color: Colors.white54)),
            hintText: "Search for ideas",
            backgroundColor: const MaterialStatePropertyAll(
                CupertinoColors.darkBackgroundGray),
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
                    gridDelegate:
                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: mediaWidth <= 550
                          ? 2
                          : true && mediaWidth <= 750 && mediaWidth > 550
                              ? 3
                              : mediaWidth > 750 && mediaWidth <= 950
                                  ? 4
                                  : 4,
                    ),
                    itemCount: productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final photo = productList[index];
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
                                  closedColor:
                                      CupertinoColors.darkBackgroundGray,
                                  openColor: CupertinoColors.darkBackgroundGray,
                                  closedBuilder: (context, invoke) {
                                    return Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              100, 20, 31, 33),
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(photo.image ?? ""),
                                            alignment: Alignment.center,
                                            fit: BoxFit.fill,
                                            filterQuality: FilterQuality.high,
                                          )),
                                      child: Center(
                                          child: Text(photo.name ?? "",
                                              style: const TextStyle(
                                                  color: Colors.white))),
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
