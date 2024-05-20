class SavedModels {
  String? id;
  String? image;
  double? wid;
  double? heights;
  int? likes;
  String saved = "false";
  String followed = "false";

  SavedModels({
    required this.id,
    required this.image,
    required this.heights,
    required this.likes,
    required this.wid,
    required this.saved,
  });

  SavedModels.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        image = json["image"],
        wid = json["wid"],
        heights = json["heights"],
        saved = json["saved"],
        followed = json["followed"],
        likes = json["likes"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["image"] = image;
    data["wid"] = wid;
    data["heights"] = heights;
    data["likes"] = likes;
    data["saved"] = saved;
    data["followed"] = followed;
    return data;
  }
}
