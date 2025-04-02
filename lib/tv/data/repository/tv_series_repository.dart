import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/tv/data/datasource/tv_series_remote_data_source.dart';
import 'package:movies_app/tv/domain/entities/tv_series.dart';
import 'package:movies_app/tv/domain/entities/tv_series_details.dart';
import 'package:movies_app/tv/domain/entities/tv_series_episode.dart';
import 'package:movies_app/tv/domain/entities/tv_series_recommendation.dart';
import 'package:movies_app/tv/domain/entities/tv_series_review.dart';
import 'package:movies_app/tv/domain/repository/base_tv_series_repository.dart';
import 'package:movies_app/tv/utils/tv_series_parameter_id.dart';

class TvSeriesRepository extends BaseTvSeriesRepository{
  final BaseTvSeriesRemoteDataSource baseTvSeriesRemoteDataSource;

  TvSeriesRepository(this.baseTvSeriesRemoteDataSource);

  @override
  Future<Either<Failure, List<TvSeries>>> getAiringTodayTvSeries() async{
    final result= await  baseTvSeriesRemoteDataSource.getAiringTodayTvSeries();
    try{
      return Right(result);

    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }

  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries()  async{
    final result= await  baseTvSeriesRemoteDataSource.getPopularTvSeries();
    try{
      return Right(result);

    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }

  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries() async{
    final result= await  baseTvSeriesRemoteDataSource.getTopRatedTvSeries();
    try{
      return Right(result);

    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }

  }

  @override
  Future<Either<Failure, List<TvSeriesReview>>> getTvSeriesReviews(TvSeriesIdParameter parameter) async {
    final result =await baseTvSeriesRemoteDataSource.getTvSeriesReviews(parameter);
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, TvSeriesDetails>> getTvSeriesDetails(TvSeriesIdParameter parameter)async {
    final result =await baseTvSeriesRemoteDataSource.getTvSeriesDetails(parameter);
    try{
    return Right(result);
    }on ServerException catch(failure){
    return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<TvSeriesRecommendation>>> getTvSeriesRecommendations(TvSeriesIdParameter parameter) async {
    final result = await baseTvSeriesRemoteDataSource.getTvSeriesRecommendations(parameter);
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<TvSeriesEpisode>>> getTvSeriesEpisodes(TvSeriesIdParameter parameter) async {
    final result = await baseTvSeriesRemoteDataSource.getTvSeriesEpisodes(parameter);
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

}