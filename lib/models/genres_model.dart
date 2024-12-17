class GenresModel {
  List<Genres>? genres;

  GenresModel({this.genres});

  GenresModel.fromJson(Map<String, dynamic> json) {
    genres = json["genres"] == null
        ? null
        : (json["genres"] as List).map((e) => Genres.fromJson(e)).toList();
  }

  static List<GenresModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(GenresModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (genres != null) {
      data["genres"] = genres?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  static List<Genres> fromList(List<Map<String, dynamic>> list) {
    return list.map(Genres.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}
