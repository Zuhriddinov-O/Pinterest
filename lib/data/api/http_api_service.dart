import "package:http/http.dart" as http;
import "package:pinterest/core/constants.dart";
import "dart:convert";

import "package:pinterest/model/model.dart";

class Api {
  static Future<PintsResponse> getWallpapers() async {
    try {
      final response =
      await http.get(Uri.parse(Constants.baseUrl), headers: {'authorization': Constants.apiKey});
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return PintsResponse.fromJson(data);
      } else {
        throw Exception("Unexpected status code: " "${response.statusCode}");
      }
    } catch(e) {
      print(e);
      throw Exception("Unexpected status code: " "");
    }
  }
}
