import 'package:equatable/equatable.dart';

class TvSeriesDetailsSeasons extends Equatable{
  final String airDate;

  const TvSeriesDetailsSeasons(
      {required this.airDate,
      required this.episodeCount,
      required this.id,
      required this.name,
      required this.overview,
      required this.posterPath,
      required this.seasonNumber,
      required this.voteAverage});

  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;
  final double voteAverage;

  @override
  // TODO: implement props
  List<Object?> get props => [airDate,episodeCount,id,name,overview,posterPath,seasonNumber,voteAverage];

}