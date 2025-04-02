
import 'package:equatable/equatable.dart';

class TvSeriesReviewAuthorDetails extends Equatable{
  final String? avatarPath;
  final double? rating;

  const TvSeriesReviewAuthorDetails({ required this.avatarPath, required this.rating});

  @override
  // TODO: implement props
  List<Object?> get props => [avatarPath,rating];

}