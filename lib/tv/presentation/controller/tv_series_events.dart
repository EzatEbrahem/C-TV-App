import 'package:equatable/equatable.dart';

abstract class TvSeriesEvent extends Equatable{

  const TvSeriesEvent();

  @override
  List<Object> get props => [];

}
class GetAiringTodayTvSeriesEvent extends TvSeriesEvent{}
class GetTopRatedTvSeriesEvent extends TvSeriesEvent{}
class GetPopularTvSeriesEvent extends TvSeriesEvent{}
class ReloadDataTvSeriesEvent extends TvSeriesEvent {}
