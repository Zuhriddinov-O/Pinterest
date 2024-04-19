import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinterest/presentation/inbox_notif_page.dart';
import 'package:pinterest/presentation/updates_notif_page.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: CupertinoColors.darkBackgroundGray,
        appBar: AppBar(
          title: const TabBar(
            automaticIndicatorColorAdjustment: true,
            labelColor: CupertinoColors.white,
            indicatorColor: CupertinoColors.white,
            dividerColor: Colors.transparent,
            overlayColor: MaterialStatePropertyAll(Colors.transparent),
            unselectedLabelColor: CupertinoColors.white,
            tabs: [
              Tab(text: "Updates"),
              Tab(text: "Inbox"),
            ],
          ),
        ),
        body: const TabBarView(children: [
          SizedBox(child: UpdatesNotifPage()),
          SizedBox(child: InboxNotifPage()),
        ]),
      ),
    );
  }
}
