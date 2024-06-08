import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinterest/presentation/view_model/home_vm.dart';
import 'package:pinterest/widgets/shimmer_updates_page.dart';
import 'package:pinterest/widgets/updated_list.dart';
import 'package:provider/provider.dart';

import '../../../specific/specific_model.dart';

class UpdatesNotifPage extends StatefulWidget {
  const UpdatesNotifPage({super.key});

  @override
  State<UpdatesNotifPage> createState() => _UpdatesNotifPageState();
}

class _UpdatesNotifPageState extends State<UpdatesNotifPage> {
  bool isLoading = true;

  @override
  void initState() {
    Provider.of<HomeViewModel>(context, listen: false).fetchPhotoList(1);
    Provider.of<HomeViewModel2>(context, listen: false).fetchPhotoList2(2);
    Future.delayed(const Duration(seconds: 3)).then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final mediaHeight = MediaQuery.of(context).size.height;
    final List<Pins> totalImages = [];
    final list1 = Provider.of<HomeViewModel>(context, listen: true).pinList;
    final list2 = Provider.of<HomeViewModel2>(context, listen: true).pinList2;
    totalImages.addAll(list1);
    totalImages.addAll(list2);

    return Scaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      body: isLoading ? shimmerUpdates(context) : updatedList(totalImages, mediaWidth, mediaHeight),
    );
  }
}
