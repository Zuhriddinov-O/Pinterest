import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinterest/presentation/pages/notification_page/updates_notif_page.dart';
import 'inbox_notif_page.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  TabController? tabController;
  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 1,
      initialIndex: initialIndex,
      child: Scaffold(
        backgroundColor: CupertinoColors.darkBackgroundGray,
        appBar: AppBar(
          title: TabBar(
            // automaticIndicatorColorAdjustment: true,
            controller: tabController,
            labelColor: CupertinoColors.white,
            indicatorColor: CupertinoColors.white,
            dividerColor: Colors.transparent,
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            unselectedLabelColor: CupertinoColors.white,
            automaticIndicatorColorAdjustment: true,
            onTap: (value) {
              setState(() {
                initialIndex = value;
                value = value == 0 ? value = 1 : 0;
              });
            },
            tabs: const [
              Tab(
                child: Text("Updates"),
              ),
              Tab(child: Text("Inbox")),
            ],
          ),
        ),
        body: TabBarView(
            dragStartBehavior: DragStartBehavior.start,
            controller: tabController,
            children: [
              SizedBox(width: width, height: height, child: const UpdatesNotifPage()),
              SizedBox(width: width, height: height, child: const InboxNotifPage()),
            ]),
      ),
    );
  }
}
