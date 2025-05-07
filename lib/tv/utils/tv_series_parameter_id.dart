import 'package:equatable/equatable.dart';

class TvSeriesIdParameter extends Equatable {
final int tvSeriesId;
final int? seasonNumber;
const TvSeriesIdParameter({ this.seasonNumber, required this.tvSeriesId});

@override
List<Object?> get props => [tvSeriesId,seasonNumber];

}