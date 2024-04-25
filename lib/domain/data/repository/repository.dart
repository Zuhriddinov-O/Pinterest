import 'package:pinterest/domain/data/model/model.dart';

import '../../../core/constants/constants.dart';
import '../network/api_service.dart';

abstract class DioRepository {
  Future<List<PinPhotos>> getPhotos();
}

class DioRepositoryImpl extends DioRepository {
  final _dioApi = DioApiService(buildDioClient(Constants.baseUrl));

  @override
  Future<String> getPhotos() async {
    try {
      final response = await _dioApi.getPhotos();
      final String pinList = response.urls?.full ?? "";
      return pinList;
    } catch (e) {
      return "";
    }
  }
}
