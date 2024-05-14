import '../domain/data/model/model.dart';

class Pins {
  String? id;
  String? username;
  String? name;
  String? firstName;
  String? bio;
  String? image;
  String? assetType;
  String? slug;
  String? blurHash;
  double? wid;
  double? heights;
  int? likes;
  User? user;


  Pins({
    required this.name,
    required this.id,
    required this.bio,
    required this.firstName,
    required this.username,
    required this.image,
    required this.assetType,
    required this.wid,
    required this.heights,
    required this.slug,
    required this.blurHash,
    required this.likes,
    required this.user,
  });

  Pins.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        id = json["id"],
        bio = json["bio"],
        firstName = json["firstName"],
        image = json["image"],
        assetType = json["assetType"],
        username = json["username"],
        wid = json["wid"],
        slug = json["slug"],
        blurHash = json["blurHash"],
        likes = json["likes"],
        user = json["user"],
        heights = json["heights"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["id"] = id;
    data["bio"] = bio;
    data["firstName"] = firstName;
    data["username"] = username;
    data["image"] = image;
    data["assetType"] = assetType;
    data["wid"] = wid;
    data["slug"] = slug;
    data["blurHash"] = blurHash;
    data["likes"] = likes;
    data["user"] = user;
    data["heights"] = heights;
    return data;
  }
}
