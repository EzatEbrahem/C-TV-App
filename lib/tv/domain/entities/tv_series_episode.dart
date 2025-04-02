import 'package:equatable/equatable.dart';


class TvSeriesEpisode extends Equatable{
  final String airDate;
  final int episodeNumber;
  final String name;
  final String overview;
  final int runtime;
  final String stillPath;
  final int showId;
  const TvSeriesEpisode(
      {required this.showId,
       required this.airDate,
        required this.episodeNumber,
        required this.name,
        required this.overview,
        required this.runtime,
        required this.stillPath,

      }
      );
  @override
  List<Object?> get props => [showId,airDate,episodeNumber,name,overview,runtime,stillPath];

}