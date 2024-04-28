class Pins {
  String? id;
  String? username;
  String? name;
  String? firstName;
  String? bio;
  String? image;
  String? assetType;

  Pins({
    required this.name,
    required this.id,
    required this.bio,
    required this.firstName,
    required this.username,
    required this.image,
    required this.assetType,
  });

  Pins.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        id = json["id"],
        bio = json["bio"],
        firstName = json["firstName"],
        image = json["image"],
        assetType = json["assetType"],
        username = json["username"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = name;
    data["id"] = id;
    data["bio"] = bio;
    data["firstName"] = firstName;
    data["username"] = username;
    data["image"] = image;
    data["assetType"] = assetType;
    return data;
  }
}
