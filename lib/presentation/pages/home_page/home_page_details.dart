import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../domain/data/comments/model/model.dart';
import '../../../domain/data/comments/respository/comment_repository.dart';
import '../../../specific/specific_model.dart';
import '../../../widgets/successCardField.dart';
import '../../view_model/home_vm.dart';

class HomePageDetails extends StatefulWidget {
  const HomePageDetails({super.key, required this.pins});

  final Pins pins;

  @override
  State<HomePageDetails> createState() => _HomePageDetailsState();
}

class _HomePageDetailsState extends State<HomePageDetails> {
  final _api = CommentsRepositoryImpl();

  @override
  void initState() {
    Provider.of<HomeViewModel>(context, listen: false).fetchPhotoList(3);
    Provider.of<HomeViewModel2>(context, listen: false).fetchPhotoList2(4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final slug = widget.pins.slug?.replaceAll("-", " ");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final pins1 = Provider.of<HomeViewModel>(context, listen: true).pinList;
    final pins2 = Provider.of<HomeViewModel2>(context, listen: true).pinList2;
    return Scaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.grey[600]),
              ),
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
                      borderRadius:
                          const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
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
                        },
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.more_horiz, color: CupertinoColors.white),
              ),
            ],
            floating: true,
            snap: true,
            pinned: true,
            expandedHeight: height,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: height,
              background: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Container(
                  width: width / 1.5,
                  height: height / 1.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: BoxBorder.lerp(
                          Border.all(color: Colors.black12, width: 2), Border.all(color: Colors.black12, width: 2), 2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                          child: ListView(
                            children: [
                              Image.network(widget.pins.image ?? "",
                                  height: height, width: width, fit: BoxFit.fill, filterQuality: FilterQuality.high),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    style: const ButtonStyle(
                                      fixedSize: MaterialStatePropertyAll(Size(25, 25)),
                                      minimumSize: MaterialStatePropertyAll(Size(20, 20)),
                                      overlayColor: MaterialStatePropertyAll(CupertinoColors.systemGrey),
                                      backgroundColor: MaterialStatePropertyAll(CupertinoColors.white),
                                    ),
                                    onPressed: () {
                                      showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) => ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                          child: BottomSheet(
                                              backgroundColor: CupertinoColors.darkBackgroundGray,
                                              enableDrag: true,
                                              dragHandleColor: Colors.lightGreen,
                                              dragHandleSize: const Size(20, 20),
                                              onClosing: () {},
                                              builder: (context) {
                                                return SizedBox(
                                                  height: height * 0.5,
                                                  width: width,
                                                  child: FutureBuilder(
                                                    future: _api.getComments(),
                                                    builder: (context, snapshot) {
                                                      if (snapshot.data != null && snapshot.data?.isNotEmpty == true) {
                                                        return successCommentField(snapshot.data ?? []);
                                                      } else if (snapshot.data?.isEmpty == true) {
                                                        return const Center(
                                                          child: Text("Empty",
                                                              style: TextStyle(
                                                                  color: CupertinoColors.white, fontSize: 25)),
                                                        );
                                                      }
                                                      return const Center(
                                                          child: SpinKitWave(color: CupertinoColors.white));
                                                    },
                                                  ),
                                                );
                                              }),
                                        ),
                                      );
                                    },
                                    icon: Image.asset(
                                      "assets/icons/love_icon.png",
                                      fit: BoxFit.fill,
                                      filterQuality: FilterQuality.high,
                                      width: 25,
                                      height: 25,
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStatePropertyAll(widget.pins.user?.forHire == true
                                            ? CupertinoColors.destructiveRed
                                            : Colors.grey[800]),
                                        foregroundColor: const MaterialStatePropertyAll(CupertinoColors.white),
                                        alignment: Alignment.center,
                                        fixedSize: MaterialStatePropertyAll(
                                            Size(width > 600 ? 120 : 100, width > 600 ? 40 : 30))),
                                    child: Text(widget.pins.user?.forHire == true ? "Save" : "Saved",
                                        textAlign: TextAlign.center, style: const TextStyle(fontSize: 15)),
                                    onPressed: () {
                                      setState(() => widget.pins.user?.forHire = !widget.pins.user!.forHire!);
                                      debugPrint(widget.pins.user?.forHire.toString());
                                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          backgroundColor: widget.pins.user?.forHire == true
                                              ? CupertinoColors.white
                                              : Colors.grey[800],
                                          content: Text(
                                            widget.pins.user?.forHire == true ? "Save" : "Saved",
                                            style: TextStyle(
                                              color: widget.pins.user?.forHire == false
                                                  ? CupertinoColors.white
                                                  : Colors.grey[800],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  width >= 550
                                      ? TextButton(
                                          onPressed: () async {
                                            await Share.share("http://GitHub.com");
                                          },
                                          child: const Icon(Icons.share, color: CupertinoColors.white),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: width > 600 ? width / 3.6 : width / 3,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(widget.pins.image ?? ""),
                                          radius: 25,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            widget.pins.user!.name ?? "",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  width > 780
                                      ? ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStatePropertyAll(
                                                  widget.pins.user?.acceptedTos == false
                                                      ? Colors.grey[800]
                                                      : CupertinoColors.white),
                                              foregroundColor: MaterialStatePropertyAll(
                                                  widget.pins.user?.acceptedTos == false
                                                      ? CupertinoColors.white
                                                      : Colors.grey[800]),
                                              alignment: Alignment.center,
                                              fixedSize: MaterialStatePropertyAll(Size(
                                                width > 750 ? 120 : 80,
                                                width > 750 ? 40 : 25,
                                              ))),
                                          child: Text(widget.pins.user?.acceptedTos == false ? "Followed" : "Follow",
                                              textAlign: TextAlign.center, style: const TextStyle(fontSize: 15)),
                                          onPressed: () {
                                            setState(
                                                () => widget.pins.user?.acceptedTos = !widget.pins.user!.acceptedTos!);
                                            debugPrint(widget.pins.user?.acceptedTos.toString());
                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                backgroundColor: widget.pins.user?.acceptedTos == false
                                                    ? Colors.grey[800]
                                                    : CupertinoColors.white,
                                                content: Text(
                                                  widget.pins.user?.acceptedTos == true ? "Follow" : "Followed",
                                                  style: TextStyle(
                                                    color: widget.pins.user?.acceptedTos == true
                                                        ? Colors.grey[800]
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            Text(widget.pins.name ?? "",
                                style: TextStyle(color: Colors.white, fontSize: width > 550 ? 25 : 20)),
                            Text(slug ?? "",
                                style: TextStyle(color: Colors.white, fontSize: width > 550 ? 25 : 20),
                                overflow: TextOverflow.ellipsis),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  width < 550
                                      ? ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStatePropertyAll(
                                                  widget.pins.user?.acceptedTos == false
                                                      ? Colors.grey[800]
                                                      : CupertinoColors.white),
                                              foregroundColor: MaterialStatePropertyAll(
                                                  widget.pins.user?.acceptedTos == false
                                                      ? CupertinoColors.white
                                                      : Colors.grey[800]),
                                              alignment: Alignment.center,
                                              fixedSize: const MaterialStatePropertyAll(Size(120, 40))),
                                          child: Text(widget.pins.user?.acceptedTos == false ? "Followed" : "Follow",
                                              textAlign: TextAlign.center, style: const TextStyle(fontSize: 15)),
                                          onPressed: () {
                                            setState(
                                                () => widget.pins.user?.acceptedTos = !widget.pins.user!.acceptedTos!);
                                            debugPrint(widget.pins.user?.acceptedTos.toString());
                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                backgroundColor: widget.pins.user?.acceptedTos == false
                                                    ? Colors.grey[800]
                                                    : CupertinoColors.white,
                                                content: Text(
                                                  widget.pins.user?.acceptedTos == true ? "Follow" : "Followed",
                                                  style: TextStyle(
                                                    color: widget.pins.user?.acceptedTos == true
                                                        ? Colors.grey[800]
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : Container(),
                                  width < 550
                                      ? TextButton(
                                          onPressed: () async {
                                            await Share.share("http://GitHub.com");
                                          },
                                          child: const Icon(Icons.share, color: CupertinoColors.white),
                                        )
                                      : Container(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              addSemanticIndexes: true,
              addRepaintBoundaries: true,
              addAutomaticKeepAlives: true,
              (context, index) => SizedBox(
                width: double.infinity,
                height: 500,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Text(
                        "More to explore",
                        style: TextStyle(color: CupertinoColors.white, fontSize: width > 550 ? 20 : 15),
                      ),
                    ),
                    SizedBox(
                      height: height,
                      child: successField(pins1, pins2, context),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  successCommentField(List<Comments> com) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child:
                      Text("${com.length.toString()} comments", style: const TextStyle(color: CupertinoColors.white))),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(widget.pins.user?.totalLikes.toString() ?? "",
                    style: const TextStyle(color: CupertinoColors.white)),
              ),
              IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.suit_heart), color: CupertinoColors.white),
            ],
          ),
        ),
        Divider(color: Colors.grey[800]),
        SizedBox(
          // color: Colors.red,
          height: MediaQuery.of(context).size.height * 0.395,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final comment = com[index];
              final cutName = comment.name!.substring(0, 1);
              final cutMain = comment.name!.substring(2);
              final capitalized = cutName.toUpperCase();
              final upperCase = capitalized + cutMain;
              return Column(
                children: [
                  SizedBox(
                    // color: Colors.blue,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.015,
                              right: MediaQuery.of(context).size.width * 0.015,
                              bottom: MediaQuery.of(context).size.width * 0.05),
                          child: CircleAvatar(
                            child: Text(cutName),
                          ),
                        ),
                        SizedBox(
                          // color: Colors.green,
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "User: $upperCase --",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: CupertinoColors.white, fontSize: 12),
                              ),
                              Text(
                                comment.body ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: CupertinoColors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey[800]),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
//use random date time for photos in updates page
