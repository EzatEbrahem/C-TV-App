import 'package:equatable/equatable.dart';

class TrailerMovie extends Equatable {
  final String name;
  final String key;
  final String site;
  final String type;
  final String id;

  const TrailerMovie(
      {required this.name,
      required this.key,
      required this.site,
      required this.type,
      required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [name, key, site, type, id];
}
