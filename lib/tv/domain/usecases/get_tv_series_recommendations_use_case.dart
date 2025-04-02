import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/tv/domain/entities/tv_series_recommendation.dart';
import 'package:movies_app/tv/domain/repository/base_tv_series_repository.dart';
import 'package:movies_app/tv/utils/tv_series_parameter_id.dart';

class GetTvSeriesRecommendationsUseCase extends BaseUseCase<List<TvSeriesRecommendation>,TvSeriesIdParameter>{
  final BaseTvSeriesRepository baseTvSeriesRepository;
  GetTvSeriesRecommendationsUseCase(this.baseTvSeriesRepository);
  @override
  Future<Either<Failure, List<TvSeriesRecommendation>>> call(TvSeriesIdParameter parameters) async {
    return await baseTvSeriesRepository.getTvSeriesRecommendations(parameters);
  }


}