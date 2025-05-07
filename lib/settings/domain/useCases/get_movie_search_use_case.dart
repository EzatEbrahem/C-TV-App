import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/settings/domain/repository/base_setting_repository.dart';

import '../Entities/movie_search.dart';

class GetMovieSearchUseCase extends BaseUseCase<List<MovieSearch>,String>{
  final BaseSettingRepository baseSettingRepository;

  GetMovieSearchUseCase(this.baseSettingRepository);

  @override
  Future<Either<Failure, List<MovieSearch>>> call(String parameters) async{
    return await baseSettingRepository.getMovieSearch(parameters);
  }

}