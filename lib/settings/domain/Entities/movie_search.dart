import 'package:equatable/equatable.dart';

class MovieSearch extends Equatable{
  final int id;
  final String backdropPath;
  final String title;

  const MovieSearch({
    required this.backdropPath,
    required this.title,
    required this.id
  });

  @override
  List<Object?> get props => [backdropPath,title];

}