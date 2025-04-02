import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/settings/data/dataSource/setting_remote_data_source.dart';
import 'package:movies_app/settings/domain/Entities/movie_search.dart';
import 'package:movies_app/settings/domain/Entities/tv_search.dart';
import 'package:movies_app/settings/domain/repository/base_setting_repository.dart';

class SettingRepository extends BaseSettingRepository{
  final BaseSettingRemoteDataSource baseSettingRemoteDataSource;
  SettingRepository(this.baseSettingRemoteDataSource);

  @override
  Future<Either<Failure, List<MovieSearch>>> getMovieSearch(String query) async {
   final result =await baseSettingRemoteDataSource.getMovieSearch(query);
   try{
     return Right(result);
   }on ServerException catch(failure){
     return Left(ServerFailure(failure.errorMessageModel.statusMessage));
   }
  }

  @override
  Future<Either<Failure, List<TvSearch>>> getTvSearch(String query)  async {
    final result =await baseSettingRemoteDataSource.getTvSearch(query);
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }


}