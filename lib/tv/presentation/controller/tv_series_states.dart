import 'package:equatable/equatable.dart';

import '../../../core/utils/enums.dart';
import '../../domain/entities/tv_series.dart';

class TvSeriesState extends Equatable{
  final List<TvSeries> airingTodayTvSeries;
  final RequestState airingTodayTvSeriesState;
  final String airingTodayTvSeriesMessage;

  final List<TvSeries> topRatedTvSeries;
  final RequestState topRatedTvSeriesState;
  final String topRatedTvSeriesMessage;

  final List<TvSeries> popularTvSeries;
  final RequestState popularTvSeriesState;
  final String popularTvSeriesMessage;
  final RequestState reloadTvSeriesScreenState;
  final ConnectState connectionState;

  const TvSeriesState({
    this.connectionState=ConnectState.online,
    this.reloadTvSeriesScreenState=RequestState.loading,
      this.airingTodayTvSeries=const[],
      this.airingTodayTvSeriesState=RequestState.loading,
      this.airingTodayTvSeriesMessage='',
      this.topRatedTvSeries=const[],
      this.topRatedTvSeriesState=RequestState.loading,
      this.topRatedTvSeriesMessage='',
      this.popularTvSeries=const[],
      this.popularTvSeriesState=RequestState.loading,
      this.popularTvSeriesMessage=''
  });
  TvSeriesState copyWith({
    ConnectState? connectionState,
    RequestState? reloadTvSeriesScreenState,
    List<TvSeries>? airingTodayTvSeries,
    RequestState? airingTodayTvSeriesState,
    String? airingTodayTvSeriesMessage,
    List<TvSeries>? topRatedTvSeries,
    RequestState? topRatedTvSeriesState,
    String? topRatedTvSeriesMessage,
    List<TvSeries>? popularTvSeries,
    RequestState? popularTvSeriesState,
    String? popularTvSeriesMessage,
  }) {
    return TvSeriesState(
      connectionState: connectionState??this.connectionState,
      reloadTvSeriesScreenState: reloadTvSeriesScreenState??this.reloadTvSeriesScreenState,
      airingTodayTvSeries: airingTodayTvSeries ?? this.airingTodayTvSeries,
      airingTodayTvSeriesState: airingTodayTvSeriesState ?? this.airingTodayTvSeriesState,
      airingTodayTvSeriesMessage: airingTodayTvSeriesMessage ?? this.airingTodayTvSeriesMessage,
      topRatedTvSeries: topRatedTvSeries ?? this.topRatedTvSeries,
      topRatedTvSeriesState: topRatedTvSeriesState ?? this.topRatedTvSeriesState,
      topRatedTvSeriesMessage: topRatedTvSeriesMessage ?? this.topRatedTvSeriesMessage,
      popularTvSeries: popularTvSeries ?? this.popularTvSeries,
      popularTvSeriesState: popularTvSeriesState ?? this.popularTvSeriesState,
      popularTvSeriesMessage: popularTvSeriesMessage ?? this.popularTvSeriesMessage,
    );
  }


  @override

  List<Object?> get props =>
      [reloadTvSeriesScreenState,
        airingTodayTvSeries,
        airingTodayTvSeriesState,
        airingTodayTvSeriesMessage,
        topRatedTvSeries,
        topRatedTvSeriesState,
        topRatedTvSeriesMessage,
        popularTvSeries,
        popularTvSeriesState,
        popularTvSeriesMessage,
        connectionState
      ];

}