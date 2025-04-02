import 'package:dartz/dartz.dart';
import 'package:movies_app/settings/domain/Entities/movie_search.dart';

import '../../../core/error/failure.dart';
import '../Entities/tv_search.dart';

abstract class BaseSettingRepository{
  Future<Either<Failure, List<TvSearch>>> getTvSearch(String query);
  Future<Either<Failure, List<MovieSearch>>> getMovieSearch(String query);
}