import 'package:flutter/widgets.dart';
import 'package:pinterest/domain/data/repository/repository.dart';

import '../../domain/data/model/model.dart';

class HomeViewModel extends ChangeNotifier {
  final DioRepository _repo = DioRepositoryImpl();
  final List<Urls> urlList = [];

  void fetchAnimeList() async {
    final list = await _repo.getPhotos();
    urlList.addAll(list);
    notifyListeners();
  }
}
