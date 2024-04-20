import 'package:pinterest/core/constants.dart';
import 'package:pinterest/data/api/api_service.dart';
import 'package:pinterest/model/model.dart';

abstract class DioRepository {
  Future<List<PinPhotos>> getPhotos();
}

class DioRepositoryImpl extends DioRepository {
  final _dioApi = DioApiService(buildDioClient(Constants.baseUrl));

  @override
  Future<List<PinPhotos>> getPhotos() async {
    try {
      final dioPhotoResponse = await _dioApi.getPhotos();
      return dioPhotoResponse.description ?? [];
    } catch (e) {
      return [];
    }
  }
}
