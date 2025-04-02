import 'package:movies_app/tv/domain/entities/tv_series.dart';

class TvSeriesModel extends TvSeries{
  const TvSeriesModel(
      {required super.id,
         required super.backdropPath,
        required super.genreIds,
        required super.name,
        required super.overview,
        required super.firstAirDate,
        required super.voteAverage
      });

  factory TvSeriesModel.fromJson(Map<String,dynamic> json){
    return TvSeriesModel(
        id: json["id"],
        backdropPath: json["backdrop_path"]??json['poster_path']??'/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg',
        genreIds:List<int>.from( json["genre_ids"].map((e) => e)),
        name: json["name"],
        overview: json["overview"],
        firstAirDate: json["first_air_date"],
        voteAverage: json["vote_average"].toDouble()
    );

  }
}