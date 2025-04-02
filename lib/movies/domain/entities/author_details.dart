import 'package:equatable/equatable.dart';

class AuthorDetails extends Equatable{
  final String? avatarPath;
  final double? rating;

  const AuthorDetails({ this.avatarPath,  this.rating});

  @override
  // TODO: implement props
  List<Object?> get props => [avatarPath,rating];

}