import 'package:movie_app/models/slideable_model.dart';

class MovieModel {
  String id;
  Results results;
  bool isWatchList;
  MovieModel({
    this.id = "",
    required this.results,
    this.isWatchList = false,
  });
  MovieModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] ?? "",
          results: Results.fromJson(json["results"]),
          isWatchList: json['isWatchList'] ?? false,
        );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["results"] = results.toJson();
    data["isWatchList"] = isWatchList;
    return data;
  }

  MovieModel copyWith({
    String? id,
    Results? results,
    bool? isWatchList,
  }) {
    return MovieModel(
      id: id ?? this.id,
      results: results ?? this.results,
      isWatchList: isWatchList ?? this.isWatchList,
    );
  }
}
