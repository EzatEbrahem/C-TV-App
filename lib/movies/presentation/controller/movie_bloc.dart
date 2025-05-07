import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/core/utils/enums.dart';
import '../../data/models/movie_hive_model.dart';
import '../../domain/usecases/get_now_playing_movies_usecase.dart';
import '../../domain/usecases/get_popular_movies_usecase.dart';
import '../../domain/usecases/get_top_rated_movies_usecase.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {

  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;

  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  MovieBloc(this.getNowPlayingMoviesUseCase, this.getPopularMoviesUseCase,
      this.getTopRatedMoviesUseCase)
      : super(const MovieState()) {
    on<GetNowPlayingMoviesEvent>((event, emit) async=> await _getNowPlayingMovies(emit));
    on<GetPopularMoviesEvent>((event, emit) async =>await _getPopularMovies(emit));
    on<GetTopRatedMoviesEvent>((event, emit)async => await _getTopRatedMovies(emit));
    on<ReloadDataMoviesEvent>((event, emit)async => await _reloadScreenMovies(emit));



  }
  FutureOr<void> _getNowPlayingMovies(Emitter<MovieState> emit) async {
    emit(state.copyWith(nowPlayingState: RequestState.loading));
    final box = await Hive.openBox<MovieHiveModel>('nowPlayingMoviesBox');
    final cachedMovies = box.values.map((e) => e.toEntity()).toList();
    final connected = await isConnected();
    if (!connected) {
      if (cachedMovies.isNotEmpty) {
        emit(state.copyWith(nowPlayingMovies: cachedMovies, nowPlayingState: RequestState.loaded));
      } else {
        emit(state.copyWith(nowPlayingState: RequestState.error, nowPlayingMessage: 'No internet connection and no local data available'));
      }
    }else{

      final result = await getNowPlayingMoviesUseCase(const NoParameters());
      await result.fold(
              (l) async =>
              emit(state.copyWith(
                nowPlayingState: RequestState.error,
                nowPlayingMessage: l.message,
              )),
              (r) async
          {
            await box.clear();
            await box.addAll(r.map((e) => MovieHiveModel.fromEntity(e)));
            emit(state.copyWith(
              nowPlayingMovies: r,
              nowPlayingState: RequestState.loaded,
            ));
          });
    }


  }
  FutureOr<void> _getTopRatedMovies(Emitter<MovieState> emit) async {
    emit(state.copyWith(topRatedState: RequestState.loading));
    final box = await Hive.openBox<MovieHiveModel>('topRatedMoviesBox');
    final cachedMovies = box.values.map((e) => e.toEntity()).toList();
    final connected = await isConnected();
    if (!connected) {
      if (cachedMovies.isNotEmpty) {
        emit(state.copyWith(topRatedMovies: cachedMovies, topRatedState: RequestState.loaded));
      } else {
        emit(state.copyWith(topRatedState: RequestState.error, topRatedMessage: 'No internet connection and no local data available'));
      }
    }else{

      final result = await getTopRatedMoviesUseCase(const NoParameters());
      await result.fold(
              (l)async =>
              emit(state.copyWith(
                topRatedState: RequestState.error,
                topRatedMessage: l.message,
              )),
              (r) async
          {
            await box.clear();
            await box.addAll(r.map((e) => MovieHiveModel.fromEntity(e)));
            emit(state.copyWith(
              topRatedMovies: r,
              topRatedState: RequestState.loaded,
            ));
          });
    }


  }
  FutureOr<void> _getPopularMovies(Emitter<MovieState> emit) async {
    emit(state.copyWith(popularState: RequestState.loading));
    final box = await Hive.openBox<MovieHiveModel>('popularMoviesBox');
    final cachedMovies = box.values.map((e) => e.toEntity()).toList();
    final connected = await isConnected();
    if (!connected) {
      if (cachedMovies.isNotEmpty) {
      emit(state.copyWith(popularMovies: cachedMovies, popularState: RequestState.loaded,popularMessage: 'Connected to internet successfully',connectionState: ConnectState.local),);
    } else {
      emit(state.copyWith(popularState: RequestState.error, popularMessage: 'No internet connection and no local data available',connectionState: ConnectState.local));
    }
    }else{
      final result = await getPopularMoviesUseCase(const NoParameters());
      await result.fold(
              (l) async=>
              emit(state.copyWith(
                popularState: RequestState.error,
                popularMessage: l.message,
                  connectionState: ConnectState.online
              )),
              (r) async
          {
            await box.clear();
            await box.addAll(r.map((e) => MovieHiveModel.fromEntity(e)));
            emit(state.copyWith(
              popularMovies: r,
              popularState: RequestState.loaded,connectionState: ConnectState.online
            ));
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

  FutureOr<void> _reloadScreenMovies(Emitter<MovieState> emit) async{
    emit(state.copyWith(reloadMovieScreenState: RequestState.loading));
      await _getPopularMovies(emit);
     await  _getTopRatedMovies(emit);
     await  _getNowPlayingMovies(emit);
    emit(state.copyWith(reloadMovieScreenState: RequestState.loaded));


  }


}
