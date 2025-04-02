import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/tv/domain/entities/tv_series.dart';
import 'package:movies_app/tv/domain/entities/tv_series_details.dart';
import 'package:movies_app/tv/domain/entities/tv_series_episode.dart';
import 'package:movies_app/tv/domain/entities/tv_series_recommendation.dart';
import 'package:movies_app/tv/domain/entities/tv_series_review.dart';

import '../../utils/tv_series_parameter_id.dart';

abstract class BaseTvSeriesRepository{
Future<Either<Failure,List<TvSeries>>> getAiringTodayTvSeries();
Future<Either<Failure,List<TvSeries>>> getTopRatedTvSeries();
Future<Either<Failure,List<TvSeries>>> getPopularTvSeries();
Future<Either<Failure,TvSeriesDetails>> getTvSeriesDetails( TvSeriesIdParameter parameter);
Future<Either<Failure, List<TvSeriesReview>>> getTvSeriesReviews(TvSeriesIdParameter parameter);
Future<Either<Failure, List<TvSeriesRecommendation>>> getTvSeriesRecommendations(TvSeriesIdParameter parameter);
Future<Either<Failure, List<TvSeriesEpisode>>> getTvSeriesEpisodes(TvSeriesIdParameter parameter);
}