import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InboxNotifPage extends StatefulWidget {
  const InboxNotifPage({super.key});

  @override
  State<InboxNotifPage> createState() => _InboxNotifPageState();
}

class _InboxNotifPageState extends State<InboxNotifPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      body: Center(child: Text("Inbox", style: TextStyle(color: CupertinoColors.white))),
    );
  }
}
