part of 'app_setting_bloc.dart';

@immutable
abstract class AppSettingEvent extends Equatable{

  const AppSettingEvent();
  @override
  List<Object?> get props => [];
}
class ChangeModeEvent extends AppSettingEvent{
  final bool? mode;

  const ChangeModeEvent({this.mode});
  @override
  List<Object?>  get props => [mode];
}
class NavigateScreenEvent extends AppSettingEvent{
 final int? index;
  const NavigateScreenEvent({this.index});
  @override
  List<Object?>  get props => [index];
}
class TvSearchEvent extends AppSettingEvent{
  final String query;

  const TvSearchEvent({required this.query});
  @override
  List<Object?>  get props => [query];
}
  class MovieSearchEvent extends AppSettingEvent{
  final String query;

  const MovieSearchEvent({required this.query});
  @override
  List<Object?>  get props => [query];
  }
