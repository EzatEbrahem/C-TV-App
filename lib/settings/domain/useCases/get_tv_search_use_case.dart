import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/settings/domain/Entities/tv_search.dart';
import 'package:movies_app/settings/domain/repository/base_setting_repository.dart';

class GetTvSearchUseCase extends BaseUseCase<List<TvSearch>,String>{
  final BaseSettingRepository baseSettingRepository;

  GetTvSearchUseCase(this.baseSettingRepository);

  @override
  Future<Either<Failure, List<TvSearch>>> call(String parameters) async{
    return await baseSettingRepository.getTvSearch(parameters);
  }

}