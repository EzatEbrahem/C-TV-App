

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';



@immutable
abstract class MovieEvent extends Equatable {

  const MovieEvent();
  @override
  List<Object> get props => [];
}
class GetNowPlayingMoviesEvent extends MovieEvent {}

class GetPopularMoviesEvent extends MovieEvent {}

class GetTopRatedMoviesEvent extends MovieEvent {}
class ReloadDataMoviesEvent extends MovieEvent {}


