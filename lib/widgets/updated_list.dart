import 'package:flutter/material.dart';
import '../specific/specific_model.dart';

updatedList(List<Pins> totalImages) {
  final List<int> updatedMinutesList = [];
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisExtent: 100),
    itemCount: totalImages.length,
    itemBuilder: (context, index) {
      final images = totalImages[index];
      final halfLength = images.updatedAt!.length / 2;
      final subStringed = images.updatedAt!.substring(halfLength + 1 as int, 19);

      final updatedMinutes = int.parse(subStringed.substring(3, 5)); //
      updatedMinutesList.add(updatedMinutes); //
      Set<int> set = updatedMinutesList.toSet();
      List<int> result = set.toList();
      result.sort((a, b) => b.compareTo(a)); //
      print("result22222----$result.length");
      return Row(
        children: [
          Container(
            child: Image.network(
              totalImages[result[index]].image ?? "",
            ),
          ),
        ],
      );
    },
  );
}
