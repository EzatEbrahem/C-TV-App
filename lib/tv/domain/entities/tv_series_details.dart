import 'package:equatable/equatable.dart';
import 'package:movies_app/tv/domain/entities/tv_series_details_seasons.dart';

class TvSeriesDetails extends Equatable{
  final int id;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final double voteAverage;
  final String type;
  final String? backdropPath;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final String lastAirDate;
  final String name;
  final String overview;
  final List<TvSeriesDetailsSeasons> seasons;


  const TvSeriesDetails({
        required this.seasons,
        required this.id,
        required this.numberOfEpisodes,
        required this.numberOfSeasons,
        required this.voteAverage,
        required this.type,
        required this.backdropPath,
        required this.episodeRunTime,
        required this.firstAirDate,
        required this.lastAirDate,
        required this.name,
        required this.overview,

      });

  @override
  // TODO: implement props
  List<Object?> get props =>
  [
    seasons,
  voteAverage,
   type,
   backdropPath,
   episodeRunTime,
   firstAirDate,
   lastAirDate,
   name,
   overview,

  ];


}