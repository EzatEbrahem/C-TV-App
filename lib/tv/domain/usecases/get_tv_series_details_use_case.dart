import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/tv/domain/entities/tv_series_details.dart';
import '../../utils/tv_series_parameter_id.dart';
import '../repository/base_tv_series_repository.dart';

class GetTvSeriesDetailsUseCase extends BaseUseCase<TvSeriesDetails,TvSeriesIdParameter > {
  final BaseTvSeriesRepository baseTvSeriesRepository;
  GetTvSeriesDetailsUseCase(this.baseTvSeriesRepository);
  @override
  Future<Either<Failure, TvSeriesDetails>> call(TvSeriesIdParameter parameters) async {
    return await baseTvSeriesRepository.getTvSeriesDetails(parameters);
  }
  
}
