
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/enums.dart';
import '../../../movies/presentation/screens/movies_screen.dart';
import '../../../tv/presentation/screens/tv_series_screen.dart';
import '../../domain/Entities/movie_search.dart';
import '../../domain/Entities/tv_search.dart';

@immutable
class AppSettingState extends Equatable {
  final ModeState modeState;
  final bool mode;
  final List<Widget> screens;
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final List<TvSearch> tvSearchList;
  final RequestState tvSearchState;
  final String tvSearchMessage;
  final List<MovieSearch> movieSearchList;
  final RequestState movieSearchState;
  final String movieSearchMessage;


  const AppSettingState({
      this.tvSearchList=const[],
      this.tvSearchState=RequestState.loading,
      this.tvSearchMessage='',
      this.movieSearchList=const[],
      this.movieSearchState=RequestState.loading,
      this.movieSearchMessage='',
    this.screens=const[MainMoviesScreen(), TvSeriesScreen()],
    this.items=const[
      BottomNavigationBarItem(label: "Movies", icon:Icon(Icons.local_movies_outlined)),
      BottomNavigationBarItem(label: "Series", icon:Icon(Icons.movie_outlined)),],
    this.currentIndex=0,
    this.mode=false,
    this.modeState = ModeState.unChanged,

  });
  AppSettingState copyWith({
    List<TvSearch>? tvSearchList,
    RequestState? tvSearchState,
    String? tvSearchMessage,
    List<MovieSearch>? movieSearchList,
    RequestState? movieSearchState,
    String? movieSearchMessage,
     ModeState? modeState ,
    bool? mode,
     List<Widget>? screens,
     List<BottomNavigationBarItem>? items,
     int? currentIndex,
  }){
    return AppSettingState(
      movieSearchList:movieSearchList??this.movieSearchList ,
        movieSearchState: movieSearchState??this.movieSearchState,
        movieSearchMessage:movieSearchMessage??this.movieSearchMessage ,
        tvSearchList:tvSearchList??this.tvSearchList ,
        tvSearchState:tvSearchState??this.tvSearchState ,
        tvSearchMessage:tvSearchMessage??this.tvSearchMessage ,
        modeState: modeState??this.modeState,
        mode:mode??this.mode,
        currentIndex:currentIndex??this.currentIndex ,
        items: items??this.items,
        screens:screens??this.screens );

  }

  @override

  List<Object?> get props => [
        modeState,
        mode,
        currentIndex,
        items,
        screens,
        movieSearchMessage,
        movieSearchState,
        movieSearchList,
        tvSearchMessage,
        tvSearchState,
        tvSearchList
      ];

}


