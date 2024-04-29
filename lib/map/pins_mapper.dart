import '../domain/data/model/model.dart';
import '../specific/specific_model.dart';

extension Map on PinPhotos {
  Pins toPin() {
    return Pins(
      name: user?.name,
      id: id,
      bio: user?.bio,
      firstName: user?.firstName,
      username: user?.username,
      image: urls?.full,
      assetType: assetType,
      wid: width,
      heights: height,
      slug: slug,
      blurHash: blurHash,
      likes: likes,
      user: user,
    );
  }
}
