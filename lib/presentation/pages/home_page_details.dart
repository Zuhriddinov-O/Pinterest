import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinterest/domain/data/model/model.dart';
import 'package:pinterest/specific/specific_model.dart';
import 'package:pinterest/widgets/app_bar_home_details.dart';

class HomePageDetails extends StatefulWidget {
  const HomePageDetails({super.key, required this.pins});

  final Pins pins;

  @override
  State<HomePageDetails> createState() => _HomePageDetailsState();
}

class _HomePageDetailsState extends State<HomePageDetails> {
  bool followBool = false;

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
                      child: Text(followBool == true ? "following" : "follow",
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
                              followBool == true ? "following" : "unfollowed",
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
              Row(
                children: [
                  IconButton(
                    style: const ButtonStyle(
                      overlayColor: MaterialStatePropertyAll(CupertinoColors.systemGrey),
                      backgroundColor: MaterialStatePropertyAll(CupertinoColors.white),
                    ),
                    onPressed: () {},
                    icon: Image.asset("assets/icons/love_icon.png"),
                  ),
                ],
              )
            ],
          ),
          appBar(context)
        ],
      ),
    );
  }
}
