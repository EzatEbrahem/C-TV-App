import 'dart:async';
import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/tv/domain/usecases/get_popular_tv_series_usecase.dart';
import 'package:movies_app/tv/domain/usecases/get_top_rated_tv_series_usecase.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_events.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_states.dart';

import '../../domain/usecases/get_airling_today_tv_series_usecase.dart';

class TvSeriesBloc extends Bloc<TvSeriesEvent,TvSeriesState>{
  final GetAiringTodayTvSeriesUseCase  getAiringTodayTvSeriesUseCase;
  final GetPopularTvSeriesUseCase  getPopularTvSeriesUseCase;
  final GetTopRatedTvSeriesUseCase  getTopRatedTvSeriesUseCase;

   TvSeriesBloc(
       this.getAiringTodayTvSeriesUseCase,
       this.getPopularTvSeriesUseCase,
       this.getTopRatedTvSeriesUseCase) : super(const TvSeriesState()){
   on<GetAiringTodayTvSeriesEvent> (_getAiringTodayTvSeries);
   on<GetPopularTvSeriesEvent> (_getPopularTvSeries);
   on<GetTopRatedTvSeriesEvent> (_getTopRatedTvSeries);

  }

  FutureOr<void> _getAiringTodayTvSeries(GetAiringTodayTvSeriesEvent event, Emitter<TvSeriesState> emit)async {
     final result =await getAiringTodayTvSeriesUseCase(const NoParameters());
     result.fold(
             (l) => emit(state.copyWith(
                 airingTodayTvSeriesState: RequestState.error,
                 airingTodayTvSeriesMessage: l.message)
             ),
             (r) => emit(state.copyWith(airingTodayTvSeriesState: RequestState.loaded,airingTodayTvSeries: r))
     );
  }

  FutureOr<void> _getPopularTvSeries(GetPopularTvSeriesEvent event, Emitter<TvSeriesState> emit)async {
    final result =await getPopularTvSeriesUseCase(const NoParameters());
    result.fold(
            (l) => emit(state.copyWith(
            popularTvSeriesState: RequestState.error,
            popularTvSeriesMessage: l.message)
        ),
            (r) => emit(state.copyWith(popularTvSeriesState: RequestState.loaded,popularTvSeries: r))
    );
  }

  FutureOr<void> _getTopRatedTvSeries(GetTopRatedTvSeriesEvent event, Emitter<TvSeriesState> emit) async {
    final result =await getTopRatedTvSeriesUseCase(const NoParameters());
    result.fold(
            (l) => emit(state.copyWith(
            topRatedTvSeriesState: RequestState.error,
            topRatedTvSeriesMessage: l.message)
        ),
            (r) => emit(state.copyWith(topRatedTvSeriesState: RequestState.loaded,topRatedTvSeries: r))
    );

  }
}