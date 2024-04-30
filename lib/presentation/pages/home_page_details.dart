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
  bool followBool = false;
  bool saveIsActive = false;
  final _api = CommentsRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final slug = widget.pins.slug?.replaceAll("-", " ");
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
                              followBool == true ? Colors.grey[800] : CupertinoColors.white),
                          foregroundColor: MaterialStatePropertyAll(
                              followBool == false ? Colors.grey[800] : CupertinoColors.white),
                          alignment: Alignment.center,
                          fixedSize: const MaterialStatePropertyAll(Size(120, 40))),
                      child: Text(followBool == true ? "Following" : "Follow",
                          textAlign: TextAlign.center, style: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        setState(() => followBool = !followBool);
                        print(followBool);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor:
                                followBool == true ? Colors.grey[800] : CupertinoColors.white,
                            content: Text(
                              followBool == true ? "Following" : "UnFollowed",
                              style: TextStyle(
                                color:
                                    followBool == false ? Colors.grey[800] : CupertinoColors.white,
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
                                    height: height * 0.3,
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
                          backgroundColor: MaterialStatePropertyAll(saveIsActive == true
                              ? Colors.grey[800]
                              : CupertinoColors.destructiveRed),
                          foregroundColor: const MaterialStatePropertyAll(CupertinoColors.white),
                          alignment: Alignment.center,
                          fixedSize: const MaterialStatePropertyAll(Size(120, 40))),
                      child: Text(saveIsActive == true ? "Saved" : "Save",
                          textAlign: TextAlign.center, style: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        setState(() => saveIsActive = !saveIsActive);
                        print(saveIsActive);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor:
                                saveIsActive == true ? Colors.grey[800] : CupertinoColors.white,
                            content: Text(
                              saveIsActive == true ? "Saved" : "Save",
                              style: TextStyle(
                                color: saveIsActive == false
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
                      child: Icon(Icons.share),
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
        const Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: Text("Comments", style: TextStyle(color: CupertinoColors.white)),
        ),
        Divider(color: Colors.grey[800]),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.21,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final comment = com[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text("${index + 1}"),
                ),
                title: Text(
                  comment.body ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: CupertinoColors.white),
                ),
                trailing: Text(
                  comment.name ?? "",
                  style: const TextStyle(color: CupertinoColors.white),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
