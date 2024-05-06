import 'package:flutter/foundation.dart';
import 'package:pinterest/domain/data/repository/repository.dart';
import 'package:pinterest/specific/specific_model.dart';

class HomeViewModel extends ChangeNotifier {
  final DioRepository _repo = DioRepositoryImpl();
  final List<Pins> pinList = [];

  void fetchPhotoList(int page) async {
    final list = await _repo.getPhotos(page);
    pinList.addAll(list);
    if (kDebugMode) {
      print("@f@@vm$list");
    }
    notifyListeners();
  }
}

class HomeViewModel2 extends ChangeNotifier {
  final DioRepository _repo = DioRepositoryImpl();
  final List<Pins> pinList2 = [];

  void fetchPhotoList2(int page) async {
    final list2 = await _repo.getPhotos(page);
    pinList2.addAll(list2);
  }
}

class HomeViewModel3 extends ChangeNotifier {
  final DioRepository _repo = DioRepositoryImpl();
  final List<Pins> pinList3 = [];

  void fetchPhotoList3(int page) async {
    final list3 = await _repo.getPhotos(page);
    list3.addAll(list3);
  }
}

