import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/tv/domain/entities/tv_series_episode.dart';
import 'package:movies_app/tv/domain/repository/base_tv_series_repository.dart';
import 'package:movies_app/tv/utils/tv_series_parameter_id.dart';

class GetTvSeriesEpisodesUseCase extends BaseUseCase<List<TvSeriesEpisode>,TvSeriesIdParameter>{
  final BaseTvSeriesRepository baseTvSeriesRepository;
  GetTvSeriesEpisodesUseCase(this.baseTvSeriesRepository);
  @override
  Future<Either<Failure, List<TvSeriesEpisode>>> call(TvSeriesIdParameter parameters) async {
    return await baseTvSeriesRepository.getTvSeriesEpisodes(parameters);
  }


}