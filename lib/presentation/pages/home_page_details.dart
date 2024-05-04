import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest/domain/data/comments/respository/comment_repository.dart';
import 'package:pinterest/presentation/view_model/home_vm.dart';
import 'package:pinterest/specific/specific_model.dart';
import 'package:pinterest/widgets/app_bar_home_details.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/data/comments/model/model.dart';

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
    Provider.of<DetailedPageViewModel>(context, listen: false).fetchAnimeList(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _api.postComments(Comments(()))
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final pins = Provider.of<DetailedPageViewModel>(context).pinList;
    // final slug = widget.pins.slug?.replaceAll("-", " ");
    return Scaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      body: Stack(
        children: [
          ListView(
            children: [
              Image.network(widget.pins.image ?? "",
                  height: height,
                  width: width,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high),
              Padding(
                padding: EdgeInsets.all(width * 0.02),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: width * 0.06,
                      foregroundImage: NetworkImage(widget.pins.image ?? ""),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: width * 0.015),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.pins.user?.username ?? "",
                                style: TextStyle(color: Colors.white, fontSize: width * 0.03)),
                            Text("${widget.pins.user?.totalPhotos ?? ""}k followers",
                                style: TextStyle(color: Colors.white, fontSize: width * 0.03)),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              widget.pins.user?.acceptedTos == true
                                  ? Colors.grey[800]
                                  : CupertinoColors.white),
                          foregroundColor: MaterialStatePropertyAll(
                              widget.pins.user?.acceptedTos == false
                                  ? Colors.grey[800]
                                  : CupertinoColors.white),
                          alignment: Alignment.center,
                          fixedSize: const MaterialStatePropertyAll(Size(120, 40))),
                      child: Text(widget.pins.user?.acceptedTos == true ? "Following" : "Follow",
                          textAlign: TextAlign.center, style: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        setState(
                            () => widget.pins.user!.acceptedTos = !widget.pins.user!.acceptedTos!);
                        debugPrint(widget.pins.user?.acceptedTos.toString());
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: widget.pins.user?.acceptedTos == true
                                ? Colors.grey[800]
                                : CupertinoColors.white,
                            content: Text(
                              widget.pins.user?.acceptedTos == true ? "Following" : "UnFollowed",
                              style: TextStyle(
                                color: widget.pins.user?.acceptedTos == false
                                    ? Colors.grey[800]
                                    : CupertinoColors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .02, vertical: width * .02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        if (snapshot.data != null &&
                                            snapshot.data?.isNotEmpty == true) {
                                          return _successCommentField(snapshot.data ?? []);
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
                          backgroundColor: MaterialStatePropertyAll(
                              widget.pins.user?.forHire == true
                                  ? Colors.grey[800]
                                  : CupertinoColors.destructiveRed),
                          foregroundColor: const MaterialStatePropertyAll(CupertinoColors.white),
                          alignment: Alignment.center,
                          fixedSize: const MaterialStatePropertyAll(Size(120, 40))),
                      child: Text(widget.pins.user?.forHire == true ? "Saved" : "Save",
                          textAlign: TextAlign.center, style: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        setState(() => widget.pins.user?.forHire = !widget.pins.user!.forHire!);
                        debugPrint(widget.pins.user?.forHire.toString());
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: widget.pins.user?.forHire == true
                                ? Colors.grey[800]
                                : CupertinoColors.white,
                            content: Text(
                              widget.pins.user?.forHire == true ? "Saved" : "Save",
                              style: TextStyle(
                                color: widget.pins.user?.forHire == false
                                    ? Colors.grey[800]
                                    : CupertinoColors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () async {
                        await Share.share("http://GitHub.com");
                      },
                      child: const Icon(Icons.share, color: CupertinoColors.white),
                    )
                  ],
                ),
              ),
              Divider(color: Colors.grey[800]),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                  "More to explore",
                  style: TextStyle(color: CupertinoColors.white),
                ),
              ),
              Container(
                height: 400,
                child: _successField(pins),
              ),
            ],
          ),
          appBar(context)
        ],
      ),
    );
  }

  _successField(List<Pins> pins) {
    // var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return MasonryGridView.builder(
      gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: width <= 550
              ? 2
              : true && width <= 750 && width > 550
                  ? 3
                  : width > 750 && width <= 950
                      ? 4
                      : 4),
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
                        SizedBox(
                          width: width / 2.5,
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
    );
  }

  _successCommentField(List<Comments> com) {
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
                  child: Text("${com.length.toString()} comments",
                      style: TextStyle(color: CupertinoColors.white))),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(widget.pins.user?.totalLikes.toString() ?? "",
                    style: const TextStyle(color: CupertinoColors.white)),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.suit_heart),
                  color: CupertinoColors.white),
            ],
          ),
        ),
        Divider(color: Colors.grey[800]),
        SizedBox(
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.025,
                              right: MediaQuery.of(context).size.width * 0.025,
                              bottom: MediaQuery.of(context).size.width * 0.05),
                          child: CircleAvatar(
                            child: Text(cutName),
                          ),
                        ),
                        SizedBox(
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
