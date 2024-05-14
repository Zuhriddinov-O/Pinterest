import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinterest/presentation/view_model/home_vm.dart';
import 'package:pinterest/widgets/home_shimmer.dart';
import 'package:pinterest/widgets/successCardField.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  @override
  void initState() {
    Provider.of<HomeViewModel>(context, listen: false).fetchPhotoList(1);
    Provider.of<HomeViewModel2>(context, listen: false).fetchPhotoList2(2);
    super.initState();
  }

  String text = "";
  bool followBool = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4)).then((value) {
      isLoading = false;
      setState(() {});
    });
    final list = Provider.of<HomeViewModel>(context, listen: true).pinList;
    final list2 = Provider.of<HomeViewModel2>(context, listen: true).pinList2;
    return Scaffold(
      appBar: AppBar(title: const Text("All", style: TextStyle(color: CupertinoColors.white))),
      backgroundColor: CupertinoColors.darkBackgroundGray,
      body: isLoading
      ? homeShimmerField(list, list2, context)
          : successField(list, list2, context)
    );
  }
}
