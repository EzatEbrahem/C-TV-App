import 'package:movies_app/tv/domain/entities/tv_series_episode.dart';

class TvSeriesEpisodeModel extends TvSeriesEpisode{
  const TvSeriesEpisodeModel({
    required super.airDate,
    required super.episodeNumber,
    required super.name,
    required super.overview,
    required super.runtime,
    required super.stillPath, required super.showId
  });
   factory TvSeriesEpisodeModel.fromJson(Map<String,dynamic> json,)=>
       TvSeriesEpisodeModel(airDate: json['air_date']??'',
           episodeNumber: json['episode_number'],
           name: json['name'],
           overview: json['overview'],
           runtime: json['runtime']??0,
           stillPath: json['still_path']??'',
         showId: json['show_id'],
       );
}