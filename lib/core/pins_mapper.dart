import 'package:pinterest/core/specific_model.dart';

import '../model/model.dart';

extension PinMapper on PinPhotos {
  Pins toPin() {
    return Pins(
      name: user?.name,
      id: id,
      altDescription: altDescription,
      bio: user?.bio,
      blurHash: blurHash,
      color: color,
      firstName: user?.firstName,
      image: urls?.regular,
      lastName: user?.lastName,
      slug: slug,
      urls: urls,
      userId: user?.id,
      userName: user?.username,
      userUpdatedAt: user?.updatedAt,
    );
  }
}
