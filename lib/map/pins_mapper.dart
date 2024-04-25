import '../domain/data/model/model.dart';
import '../specific/specific_model.dart';

extension Map on User {
  Pins toPin() {
    return Pins(
      name: name,
      id: id,
      bio: bio,
      firstName: firstName,
      lastName: lastName,
      userName: name,
      userId: totalLikes,
    );
  }
}

extension PinMapperUrls on Urls {
  PhotoUrls toUrl() {
    return PhotoUrls(full: full);
  }
}
