import 'package:movies_app/tv/domain/entities/tv_series_details_seasons.dart';

class TvSeriesDetailsSeasonsModel extends TvSeriesDetailsSeasons{
  const TvSeriesDetailsSeasonsModel({
    required super.airDate,
    required super.episodeCount,
    required super.id,
    required super.name,
    required super.overview,
    required super.posterPath,
    required super.seasonNumber,
    required super.voteAverage
  });
  factory TvSeriesDetailsSeasonsModel.fromJson(Map<String,dynamic> json,String json2,String json3)=>
      TvSeriesDetailsSeasonsModel(
      airDate: json["air_date"]??json3,
      episodeCount: json['episode_count'],
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      posterPath: json['poster_path']??json2??'//ta17TltHGdZ5PZz6oUD3N5BRurb.jpg',
      seasonNumber: json['season_number'],
      voteAverage: json['vote_average'],
  );
}