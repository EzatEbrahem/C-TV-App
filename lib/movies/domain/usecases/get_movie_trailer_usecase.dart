import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/movies/domain/entities/trailer.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

class GetMovieTrailerUseCase extends BaseUseCase<TrailerMovie,MovieTrailerParameters>{
  final BaseMoviesRepository baseMoviesRepository;

  GetMovieTrailerUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, TrailerMovie>> call(MovieTrailerParameters parameters) async{
    return await baseMoviesRepository.getMovieTrailer(parameters);

  }

}
class MovieTrailerParameters extends Equatable {
  final int movieId;

  const MovieTrailerParameters({required this.movieId});

  @override
  List<Object> get props => [movieId];
}