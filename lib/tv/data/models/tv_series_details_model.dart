import 'package:movies_app/tv/data/models/tv_series_details_seasons_model.dart';
import 'package:movies_app/tv/domain/entities/tv_series_details.dart';

class TvSeriesDetailsModel extends TvSeriesDetails{
  const TvSeriesDetailsModel(
      {
        required super.id,
        required super.numberOfEpisodes,
        required super.numberOfSeasons,
        required super.voteAverage,
        required super.type,
         super.backdropPath,
         required super.episodeRunTime,
        required super.firstAirDate,
        required super.lastAirDate,
        required super.name,
        required super.overview,
        required super.seasons,

      });

  factory TvSeriesDetailsModel.fromJson(Map<String,dynamic> json)=> TvSeriesDetailsModel(
      id: json["id"],
      numberOfEpisodes: json["number_of_episodes"],
      numberOfSeasons: json["number_of_seasons"],
      voteAverage: json["vote_average"],
      type: json["type"],
      backdropPath: json["backdrop_path"]??json['poster_path']??'/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg',
      episodeRunTime: List<int>.from(json["episode_run_time"].map((e)=>e)),
      firstAirDate: json["first_air_date"],
      lastAirDate: json["last_air_date"]??'',
      name: json["name"],
      overview: json["overview"],
    seasons:List<TvSeriesDetailsSeasonsModel>.from(json['seasons'].map((e)=>
        TvSeriesDetailsSeasonsModel.fromJson(e,json["backdrop_path"]??'/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg',json["last_air_date"]??''))),

  );
}