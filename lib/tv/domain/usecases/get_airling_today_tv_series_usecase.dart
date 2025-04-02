import 'package:dartz/dartz.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/tv/domain/repository/base_tv_series_repository.dart';
import '../../../core/error/failure.dart';
import '../entities/tv_series.dart';
class  GetAiringTodayTvSeriesUseCase extends BaseUseCase<List<TvSeries>,NoParameters> {

  final BaseTvSeriesRepository baseTvSeriesRepository;


  GetAiringTodayTvSeriesUseCase(this.baseTvSeriesRepository);

  @override
  Future<Either<Failure,List<TvSeries>>> call(NoParameters parameters) async{
  return await baseTvSeriesRepository.getAiringTodayTvSeries();
  }


}