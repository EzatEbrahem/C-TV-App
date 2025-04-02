import 'package:get_it/get_it.dart';
import 'package:movies_app/movies/data/datasource/movie_remote_data_source.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';
import 'package:movies_app/movies/domain/usecases/get_movie_detail_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_recommendation_movies_usecase.dart';
import 'package:movies_app/movies/presentation/controller/movie_detail_bloc.dart';
import 'package:movies_app/tv/data/datasource/tv_series_remote_data_source.dart';
import 'package:movies_app/tv/data/repository/tv_series_repository.dart';
import 'package:movies_app/tv/domain/repository/base_tv_series_repository.dart';
import 'package:movies_app/tv/domain/usecases/get_airling_today_tv_series_usecase.dart';
import 'package:movies_app/tv/domain/usecases/get_popular_tv_series_usecase.dart';
import 'package:movies_app/tv/domain/usecases/get_top_rated_tv_series_usecase.dart';
import 'package:movies_app/tv/domain/usecases/get_tv_series_episodes_use_case.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_bloc.dart';

import '../../movies/data/repository/movies_repository.dart';
import '../../movies/domain/usecases/get_movie_reviews_usecase.dart';
import '../../movies/domain/usecases/get_movie_trailer_usecase.dart';
import '../../movies/domain/usecases/get_popular_movies_usecase.dart';
import '../../movies/domain/usecases/get_top_rated_movies_usecase.dart';
import '../../settings/data/dataSource/setting_remote_data_source.dart';
import '../../settings/data/repository/setting_repository.dart';
import '../../settings/domain/repository/base_setting_repository.dart';
import '../../settings/domain/useCases/get_movie_search_use_case.dart';
import '../../settings/domain/useCases/get_tv_search_use_case.dart';
import '../../settings/presentation/controller/app_setting_bloc.dart';
import '../../movies/presentation/controller/movie_bloc.dart';
import '../../tv/domain/usecases/get_tv_series_details_use_case.dart';
import '../../tv/domain/usecases/get_tv_series_recommendations_use_case.dart';
import '../../tv/domain/usecases/get_tv_series_reviews_use_case.dart';
import '../../tv/presentation/controller/tv_series_details_bloc.dart';

final sl = GetIt.instance;
class ServicesLocator {
void init(){
  ///bloc
sl.registerFactory(() => MovieBloc(sl(),sl(),sl()));
sl.registerFactory(() => TvSeriesBloc(sl(),sl(),sl()));
sl.registerFactory(() => MovieDetailBloc(sl(),sl(),sl(),sl()));
sl.registerFactory(() => TvSeriesDetailsBloc(sl(),sl(),sl(),sl()));
sl.registerFactory(() => AppSettingBloc(sl(),sl()));
///useCases
sl.registerLazySingleton(() => GetNowPlayingMoviesUseCase(sl()));
sl.registerLazySingleton(() => GetPopularMoviesUseCase(sl()));
sl.registerLazySingleton(() => GetTopRatedMoviesUseCase(sl()));
sl.registerLazySingleton(() => GetMovieDetailUseCase(sl()));
sl.registerLazySingleton(() => GetRecommendationUseCase(sl()));
sl.registerLazySingleton(() => GetMovieTrailerUseCase(sl()));
sl.registerLazySingleton(() => GetMovieReviewsUseCase(sl()));
sl.registerLazySingleton(() => GetAiringTodayTvSeriesUseCase(sl()));
sl.registerLazySingleton(() => GetTopRatedTvSeriesUseCase(sl()));
sl.registerLazySingleton(() => GetPopularTvSeriesUseCase(sl()));
sl.registerLazySingleton(() => GetTvSeriesDetailsUseCase(sl()));
sl.registerLazySingleton(() => GetTvSeriesReviewsUseCase(sl()));
sl.registerLazySingleton(() => GetTvSeriesRecommendationsUseCase(sl()));
sl.registerLazySingleton(() => GetTvSeriesEpisodesUseCase(sl()));
sl.registerLazySingleton(() => GetTvSearchUseCase(sl()));
sl.registerLazySingleton(() => GetMovieSearchUseCase(sl()));
///repository
  sl.registerLazySingleton<BaseMoviesRepository>(() => MoviesRepository(sl()));
  sl.registerLazySingleton<BaseTvSeriesRepository>(() => TvSeriesRepository(sl()));
  sl.registerLazySingleton<BaseSettingRepository>(() => SettingRepository(sl()));


  ///data Source
  sl.registerLazySingleton<BaseMovieRemoteDataSource>(() => MovieRemoteDataSource());
  sl.registerLazySingleton<BaseTvSeriesRemoteDataSource>(() => TvSeriesRemoteDataSource());
  sl.registerLazySingleton<BaseSettingRemoteDataSource>(() => SettingRemoteDataSource());
}
}