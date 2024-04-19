import '../model/model.dart';

class Pins {
  Urls? urls;
  String? id,
      slug,
      createdAt,
      updatedAt,
      promotedAt,
      color,
      blurHash,
      description,
      altDescription,
      image,
      userId,
      userUpdatedAt,
      userName,
      name,
      firstName,
      lastName,
      bio;

  Pins({
    required this.name,
    required this.id,
    required this.altDescription,
    required this.bio,
    required this.blurHash,
    required this.color,
    required this.createdAt,
    required this.description,
    required this.firstName,
    required this.image,
    required this.lastName,
    required this.promotedAt,
    required this.slug,
    required this.updatedAt,
    required this.urls,
    required this.userId,
    required this.userName,
    required this.userUpdatedAt,
  });

  Pins.fromJSon(Map<String, dynamic> json)
      : name = json["name"],
        id = json["id"],
        altDescription = json["altDescription"],
        bio = json["bio"],
        blurHash = json["blurHash"],
        color = json["color"],
        createdAt = json["createdAt"],
        description = json["description"],
        firstName = json["firstName"],
        image = json["image"],
        lastName = json["lastName"],
        promotedAt = json["promotedAt"],
        slug = json["slug"],
        updatedAt = json["updatedAt"],
        urls = json["urls"],
        userId = json["userId"],
        userName = json["userName"],
        userUpdatedAt = json["userUpdatedAt"];
}
