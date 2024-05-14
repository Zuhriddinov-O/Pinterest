import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar appBar(context, bool forceManualTransparency) {
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  return AppBar(
    forceMaterialTransparency: forceManualTransparency,
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
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
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
  );
}
