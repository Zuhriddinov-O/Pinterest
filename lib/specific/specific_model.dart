class Pins {
  String? id;
  int? userId;
  String? userName;
  String? name;
  String? firstName;
  String? lastName;
  String? bio;

  Pins({
    required this.name,
    required this.id,
    required this.bio,
    required this.firstName,
    required this.lastName,
    required this.userId,
    required this.userName,
  });

  Pins.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        id = json["id"],
        bio = json["bio"],
        firstName = json["firstName"],
        lastName = json["lastName"],
        userId = json["userId"],
        userName = json["userName"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = name;
    data["id"] = id;
    data["bio"] = bio;
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["userId"] = userId;
    data["userName"] = userName;
    return data;
  }
}

class PhotoUrls {
  String? full;

  PhotoUrls({required this.full});

  PhotoUrls.fromJson(Map<String, dynamic> json) : full = json["full"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["full"] = full;
    return data;
  }
}
