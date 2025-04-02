import 'package:equatable/equatable.dart';

class TvSearch extends Equatable{
  final int id;
  final String backdropPath;
  final String name;

  const TvSearch({
    required this.backdropPath,
    required this.name,
    required this.id
  });

  @override
  List<Object?> get props => [backdropPath,name];

}