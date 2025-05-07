import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/tv/domain/usecases/get_popular_tv_series_usecase.dart';
import 'package:movies_app/tv/domain/usecases/get_top_rated_tv_series_usecase.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_events.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_states.dart';
import '../../data/models/tv_series_hive_model.dart';
import '../../domain/usecases/get_airling_today_tv_series_usecase.dart';

class TvSeriesBloc extends Bloc<TvSeriesEvent,TvSeriesState>{
  final GetAiringTodayTvSeriesUseCase  getAiringTodayTvSeriesUseCase;
  final GetPopularTvSeriesUseCase  getPopularTvSeriesUseCase;
  final GetTopRatedTvSeriesUseCase  getTopRatedTvSeriesUseCase;

   TvSeriesBloc(
       this.getAiringTodayTvSeriesUseCase,
       this.getPopularTvSeriesUseCase,
       this.getTopRatedTvSeriesUseCase) : super(const TvSeriesState()){
     on<GetAiringTodayTvSeriesEvent>((event, emit) =>_getAiringTodayTvSeries(emit));
     on<GetPopularTvSeriesEvent>((event, emit) => _getPopularTvSeries(emit));
     on<GetTopRatedTvSeriesEvent>((event, emit) =>_getTopRatedTvSeries(emit));
     on<ReloadDataTvSeriesEvent>(_reloadDataMoviesEvent);

  }

  FutureOr<void> _getAiringTodayTvSeries( Emitter<TvSeriesState> emit)async {
    emit(state.copyWith(airingTodayTvSeriesState: RequestState.loading));
    final box = await Hive.openBox<TvSeriesHiveModel>('AiringTodayTvSeriesBox');
    final cachedMovies = box.values.map((e) => e.toEntity()).toList();
    final connected = await isConnected();
    if (!connected) {
      if (cachedMovies.isNotEmpty) {
        emit(state.copyWith(airingTodayTvSeries: cachedMovies, airingTodayTvSeriesState: RequestState.loaded,connectionState: ConnectState.local));
      } else {
        emit(state.copyWith(connectionState: ConnectState.local,airingTodayTvSeriesState: RequestState.error, airingTodayTvSeriesMessage: 'No internet connection and no local data available'));
      }
    }else{
    final result =await getAiringTodayTvSeriesUseCase(const NoParameters());
    await result.fold(
             (l) async=> emit(state.copyWith(
                 airingTodayTvSeriesState: RequestState.error,
                 airingTodayTvSeriesMessage: l.message,connectionState: ConnectState.online)
             ),
             (r) async  {
               await box.clear();
               await box.addAll(r.map((e) => TvSeriesHiveModel.fromEntity(e)));
             emit(state.copyWith(
             airingTodayTvSeriesState: RequestState.loaded, airingTodayTvSeries: r,connectionState: ConnectState.online));
    });
    }
  }

  FutureOr<void> _getPopularTvSeries( Emitter<TvSeriesState> emit)async {
    emit(state.copyWith(popularTvSeriesState: RequestState.loading));
    final box = await Hive.openBox<TvSeriesHiveModel>('popularTvSeriesBox');
    final cachedMovies = box.values.map((e) => e.toEntity()).toList();
    final connected = await isConnected();
    if (!connected) {
      if (cachedMovies.isNotEmpty) {
        emit(state.copyWith(popularTvSeries: cachedMovies, popularTvSeriesState: RequestState.loaded,connectionState: ConnectState.local));
      } else {
        emit(state.copyWith(connectionState: ConnectState.local,popularTvSeriesState: RequestState.error, popularTvSeriesMessage: 'No internet connection and no local data available'));
      }
    }else{
      final result =await getPopularTvSeriesUseCase(const NoParameters());
      await result.fold(
              (l) async=> emit(state.copyWith(
              popularTvSeriesState: RequestState.error,
              popularTvSeriesMessage: l.message,connectionState: ConnectState.online)
          ),
              (r) async  {
            await box.clear();
            await box.addAll(r.map((e) => TvSeriesHiveModel.fromEntity(e)));
            emit(state.copyWith(
                popularTvSeriesState: RequestState.loaded, popularTvSeries: r,connectionState: ConnectState.online));
          });
    }
  }

  FutureOr<void> _getTopRatedTvSeries( Emitter<TvSeriesState> emit) async {
    emit(state.copyWith(topRatedTvSeriesState: RequestState.loading));
    final box = await Hive.openBox<TvSeriesHiveModel>('topRatedTvSeriesBox');
    final cachedMovies = box.values.map((e) => e.toEntity()).toList();
    final connected = await isConnected();
    if (!connected) {
      if (cachedMovies.isNotEmpty) {
        emit(state.copyWith(topRatedTvSeries: cachedMovies, topRatedTvSeriesState: RequestState.loaded,connectionState: ConnectState.local));
      } else {
        emit(state.copyWith(connectionState: ConnectState.local,topRatedTvSeriesState: RequestState.error, topRatedTvSeriesMessage: 'No internet connection and no local data available'));
      }
    }else{
      final result =await getTopRatedTvSeriesUseCase(const NoParameters());
      await result.fold(
              (l) async=> emit(state.copyWith(
                  topRatedTvSeriesState: RequestState.error,
              topRatedTvSeriesMessage: l.message,connectionState: ConnectState.online)
          ),
              (r) async  {
            await box.clear();
            await box.addAll(r.map((e) => TvSeriesHiveModel.fromEntity(e)));
            emit(state.copyWith(
                topRatedTvSeriesState: RequestState.loaded, topRatedTvSeries: r,connectionState: ConnectState.online));
          });
    }

  }
  Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }
  FutureOr<void> _reloadDataMoviesEvent(ReloadDataTvSeriesEvent event, Emitter<TvSeriesState> emit)async {
    await _getAiringTodayTvSeries(emit);
    await _getTopRatedTvSeries(emit);
    await   _getPopularTvSeries(emit);

    emit(state.copyWith(reloadTvSeriesScreenState: RequestState.loaded));
  }
}