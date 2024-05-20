import '../domain/data/model/model.dart';

class Pins {
  String? id;
  String? username;
  String? name;
  String? firstName;
  String? bio;
  String? image;
  String? slug;
  double? wid;
  double? heights;
  int? likes;
  User? user;
  String? updatedAt;
  int? totalPromotedPhotos;
  int? totalIllustrations;
  int? totalPromotedIllustrations;

  Pins(
      {required this.name,
      required this.id,
      required this.bio,
      required this.firstName,
      required this.username,
      required this.image,
      required this.wid,
      required this.heights,
      required this.slug,
      required this.likes,
      required this.user,
      required this.updatedAt,
      required this.totalIllustrations,
      required this.totalPromotedPhotos,
      required this.totalPromotedIllustrations});

  Pins.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        id = json["id"],
        bio = json["bio"],
        firstName = json["firstName"],
        image = json["image"],
        username = json["username"],
        wid = json["wid"],
        slug = json["slug"],
        likes = json["likes"],
        user = json["user"],
        updatedAt = json["updatedAt"],
        totalIllustrations = json["totalIllustrations"],
        totalPromotedPhotos = json["totalPromotedPhotos"],
        totalPromotedIllustrations = json["totalPromotedIllustrations"],
        heights = json["heights"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["id"] = id;
    data["bio"] = bio;
    data["firstName"] = firstName;
    data["username"] = username;
    data["image"] = image;
    data["wid"] = wid;
    data["slug"] = slug;
    data["likes"] = likes;
    data["user"] = user;
    data["updatedAt"] = updatedAt;
    data["totalIllustrations"] = totalIllustrations;
    data["totalPromotedPhotos"] = totalPromotedPhotos;
    data["totalPromotedIllustrations"] = totalPromotedIllustrations;
    data["heights"] = heights;
    return data;
  }
}
