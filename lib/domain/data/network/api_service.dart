import "package:dio/dio.dart" hide Headers;
import "package:pinterest/domain/data/model/model.dart";
import "package:pretty_dio_logger/pretty_dio_logger.dart";
import "package:retrofit/retrofit.dart";
import "../../../core/constants/constants.dart";
part 'api_service.g.dart';

@RestApi()
abstract class DioApiService {
  factory DioApiService(Dio dio, {String baseUrl}) = _DioApiService;

  @Headers({"Authorization": Constants.apiKey})
  @GET("/photos")
  Future<List<PinPhotos>> getPhotos(@Query("page") int page);
}

Dio buildDioClient(String baseUrl) {
  final dio = Dio()..options = BaseOptions(baseUrl: baseUrl);
  dio.interceptors.addAll([
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      error: true,
      compact: true,
      request: true,
      responseHeader: true,
      maxWidth: 90,
    )
  ]);
  return dio;
}
