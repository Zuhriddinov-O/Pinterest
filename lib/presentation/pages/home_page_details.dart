import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pinterest/domain/data/comments/respository/comment_repository.dart';
import 'package:pinterest/specific/specific_model.dart';
import 'package:pinterest/widgets/app_bar_home_details.dart';
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
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                                          return const Text("Empty",
                                              style: TextStyle(
                                                  color: CupertinoColors.white, fontSize: 25));
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
            ],
          ),
          appBar(context)
        ],
      ),
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
              const Expanded(
                  child: Text("Comments", style: TextStyle(color: CupertinoColors.white))),
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
                  Divider(color: Colors.grey[800])
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
