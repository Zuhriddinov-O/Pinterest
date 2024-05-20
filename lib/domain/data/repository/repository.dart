import 'package:pinterest/map/pins_mapper.dart';
import 'package:pinterest/specific/specific_model.dart';
import '../../../core/constants/constants.dart';
import '../network/api_service.dart';

abstract class DioRepository {
  Future<List<Pins>> getPhotos(int page);
}

class DioRepositoryImpl extends DioRepository {
  final _dioApi = DioApiService(buildDioClient(Constants.baseUrl));
  @override
  Future<List<Pins>> getPhotos(int page) async {
    try {
      final images = await _dioApi.getPhotos(page);
      return images.map((e) => e.toPin()).toList();
    } catch (e) {
      print("@@@ $e");
      return [];
    }
  }
}
