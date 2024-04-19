import 'package:pinterest/core/specific_model.dart';

import '../model/model.dart';

extension PinMapper on PintsResponse {
  Pins toPin() {
    return Pins(
      name: user?.name,
      id: id,
      altDescription: altDescription,
      bio: user?.bio,
      blurHash: blurHash,
      color: color,
      createdAt: createdAt,
      description: description,
      firstName: user?.firstName,
      image: urls?.regular,
      lastName: user?.lastName,
      promotedAt: promotedAt,
      slug: slug,
      updatedAt: updatedAt,
      urls: urls,
      userId: user?.id,
      userName: user?.username,
      userUpdatedAt: user?.updatedAt,
    );
  }
}
