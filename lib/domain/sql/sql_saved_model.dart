class Favorites {
  String? id, color, altDescription, image, userId, userName, name, firstName, lastName, bio;

  Favorites({
    required this.name,
    required this.id,
    required this.altDescription,
    required this.bio,
    required this.color,
    required this.firstName,
    required this.image,
    required this.lastName,
    required this.userId,
    required this.userName,
  });

  Favorites.fromJSon(Map<String, dynamic> json)
      : name = json["name"],
        id = json["id"],
        altDescription = json["altDescription"],
        bio = json["bio"],
        color = json["color"],
        firstName = json["firstName"],
        image = json["image"],
        lastName = json["lastName"],
        userId = json["userId"],
        userName = json["userName"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["altDescription"] = altDescription;
    data["bio"] = bio;
    data["color"] = color;
    data["firstName"] = firstName;
    data["image"] = image;
    data["lastName"] = lastName;
    data["userId"] = userId;
    data["userName"] = userName;
    return data;
  }
}
