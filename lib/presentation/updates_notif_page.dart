import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdatesNotifPage extends StatefulWidget {
  const UpdatesNotifPage({super.key});

  @override
  State<UpdatesNotifPage> createState() => _UpdatesNotifPageState();
}

class _UpdatesNotifPageState extends State<UpdatesNotifPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      body: Center(child: Text("Updates", style: TextStyle(color: CupertinoColors.white))),
    );
  }
}
