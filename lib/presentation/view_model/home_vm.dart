import 'package:flutter/widgets.dart';
import 'package:pinterest/domain/data/repository/repository.dart';
import 'package:pinterest/specific/specific_model.dart';

import '../../domain/data/model/model.dart';

class HomeViewModel extends ChangeNotifier {
  final DioRepository _repo = DioRepositoryImpl();
  final List<Pins> pinList = [];

  void fetchAnimeList() async {
    final list = await _repo.getPhotos();
    print("@f@@vm$list");
    pinList.addAll(list);
    print("@f@@vm$list");
    notifyListeners();
  }
}
