import 'package:movie_app/models/genres_model.dart';

class DetailsModel {
  bool? adult;
  String? backdropPath;
  BelongsToCollection? belongsToCollection;
  int? budget;
  List<Genres>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompanies>? productionCompanies;
  List<ProductionCountries>? productionCountries;
  String? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  DetailsModel(
      {this.adult,
      this.backdropPath,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homepage,
      this.id,
      this.imdbId,
      this.originCountry,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  DetailsModel.fromJson(Map<String, dynamic> json) {
    adult = json["adult"];
    backdropPath = json["backdrop_path"];
    belongsToCollection = json["belongs_to_collection"] == null
        ? null
        : BelongsToCollection.fromJson(json["belongs_to_collection"]);
    budget = json["budget"];
    genres = json["genres"] == null
        ? null
        : (json["genres"] as List).map((e) => Genres.fromJson(e)).toList();
    homepage = json["homepage"];
    id = json["id"] != null ? (json["id"] as num).toInt() : null;
    imdbId = json["imdb_id"];
    originCountry = json["origin_country"] == null
        ? null
        : List<String>.from(json["origin_country"]);
    originalLanguage = json["original_language"];
    originalTitle = json["original_title"];
    overview = json["overview"];
    popularity = json["popularity"];
    posterPath = json["poster_path"];
    productionCompanies = json["production_companies"] == null
        ? null
        : (json["production_companies"] as List)
            .map((e) => ProductionCompanies.fromJson(e))
            .toList();
    productionCountries = json["production_countries"] == null
        ? null
        : (json["production_countries"] as List)
            .map((e) => ProductionCountries.fromJson(e))
            .toList();
    releaseDate = json["release_date"];
    revenue = json["revenue"];
    runtime = json["runtime"];
    spokenLanguages = json["spoken_languages"] == null
        ? null
        : (json["spoken_languages"] as List)
            .map((e) => SpokenLanguages.fromJson(e))
            .toList();
    status = json["status"];
    tagline = json["tagline"];
    title = json["title"];
    video = json["video"];
    voteAverage = json["vote_average"];
    voteCount = json["vote_count"];
  }

  static List<DetailsModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(DetailsModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["adult"] = adult;
    data["backdrop_path"] = backdropPath;
    if (belongsToCollection != null) {
      data["belongs_to_collection"] = belongsToCollection?.toJson();
    }
    data["budget"] = budget;
    if (genres != null) {
      data["genres"] = genres?.map((e) => e.toJson()).toList();
    }
    data["homepage"] = homepage;
    data["id"] = id;
    data["imdb_id"] = imdbId;
    if (originCountry != null) {
      data["origin_country"] = originCountry;
    }
    data["original_language"] = originalLanguage;
    data["original_title"] = originalTitle;
    data["overview"] = overview;
    data["popularity"] = popularity;
    data["poster_path"] = posterPath;
    if (productionCompanies != null) {
      data["production_companies"] =
          productionCompanies?.map((e) => e.toJson()).toList();
    }
    if (productionCountries != null) {
      data["production_countries"] =
          productionCountries?.map((e) => e.toJson()).toList();
    }
    data["release_date"] = releaseDate;
    data["revenue"] = revenue;
    data["runtime"] = runtime;
    if (spokenLanguages != null) {
      data["spoken_languages"] =
          spokenLanguages?.map((e) => e.toJson()).toList();
    }
    data["status"] = status;
    data["tagline"] = tagline;
    data["title"] = title;
    data["video"] = video;
    data["vote_average"] = voteAverage;
    data["vote_count"] = voteCount;
    return data;
  }
}

class SpokenLanguages {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguages({this.englishName, this.iso6391, this.name});

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    englishName = json["english_name"];
    iso6391 = json["iso_639_1"];
    name = json["name"];
  }

  static List<SpokenLanguages> fromList(List<Map<String, dynamic>> list) {
    return list.map(SpokenLanguages.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["english_name"] = englishName;
    data["iso_639_1"] = iso6391;
    data["name"] = name;
    return data;
  }
}

class ProductionCountries {
  String? iso31661;
  String? name;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso31661 = json["iso_3166_1"];
    name = json["name"];
  }

  static List<ProductionCountries> fromList(List<Map<String, dynamic>> list) {
    return list.map(ProductionCountries.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["iso_3166_1"] = iso31661;
    data["name"] = name;
    return data;
  }
}

class ProductionCompanies {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompanies.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    logoPath = json["logo_path"];
    name = json["name"];
    originCountry = json["origin_country"];
  }

  static List<ProductionCompanies> fromList(List<Map<String, dynamic>> list) {
    return list.map(ProductionCompanies.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["logo_path"] = logoPath;
    data["name"] = name;
    data["origin_country"] = originCountry;
    return data;
  }
}

class BelongsToCollection {
  int? id;
  String? name;
  String? posterPath;
  String? backdropPath;

  BelongsToCollection({this.id, this.name, this.posterPath, this.backdropPath});

  BelongsToCollection.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    posterPath = json["poster_path"];
    backdropPath = json["backdrop_path"];
  }

  static List<BelongsToCollection> fromList(List<Map<String, dynamic>> list) {
    return list.map(BelongsToCollection.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["poster_path"] = posterPath;
    data["backdrop_path"] = backdropPath;
    return data;
  }
}
