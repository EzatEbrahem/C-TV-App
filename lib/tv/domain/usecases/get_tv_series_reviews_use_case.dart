import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/tv/domain/entities/tv_series_review.dart';
import 'package:movies_app/tv/domain/repository/base_tv_series_repository.dart';
import '../../utils/tv_series_parameter_id.dart';

class GetTvSeriesReviewsUseCase extends BaseUseCase<List<TvSeriesReview>,TvSeriesIdParameter > {
  final BaseTvSeriesRepository baseTvSeriesRepository;
  GetTvSeriesReviewsUseCase(this.baseTvSeriesRepository);

  @override
  Future<Either<Failure, List<TvSeriesReview>>> call(TvSeriesIdParameter parameter) async{
    return await baseTvSeriesRepository.getTvSeriesReviews(parameter);
  }
  
}
