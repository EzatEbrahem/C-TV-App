import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/settings/domain/useCases/get_tv_search_use_case.dart';
import '../../../core/network/cache_helper.dart';
import '../../domain/useCases/get_movie_search_use_case.dart';
import 'app_setting_event.dart';
import 'app_setting_state.dart';


class AppSettingBloc extends Bloc<AppSettingEvent, AppSettingState> {
  final GetTvSearchUseCase getTvSearchUseCase;
  final GetMovieSearchUseCase getMovieSearchUseCase;
    bool isDark=false;
  AppSettingBloc(this.getTvSearchUseCase, this.getMovieSearchUseCase) : super(const AppSettingState()) {
    on<ChangeModeEvent>(_changeMode);
    on<NavigateScreenEvent>(_navigateScreens);
    on<MovieSearchEvent>(_movieSearch);
    on<TvSearchEvent>(_tvSearch);

  }

  FutureOr<void> _changeMode(ChangeModeEvent event, Emitter<AppSettingState> emit) async{

      if(event.mode!=null){

        isDark=event.mode!;
        await CacheHelper.putMode(key: "isDark", value: isDark).then((value) {
          emit(state.copyWith(modeState:ModeState.changed,mode: isDark));
        });
      }else{

        isDark=!isDark;
        await CacheHelper.putMode(key: "isDark", value: isDark).then((value){
           emit(state.copyWith(modeState:ModeState.changed,mode: isDark));
        });
      }

    }

  FutureOr<void> _navigateScreens(NavigateScreenEvent event, Emitter<AppSettingState> emit){
    emit(state.copyWith(
       currentIndex: event.index));

  }

  FutureOr<void> _movieSearch(MovieSearchEvent event, Emitter<AppSettingState> emit) async {
    final result=await getMovieSearchUseCase(event.query);
    result.fold(
            (l) => emit(
                state.copyWith(
              movieSearchState: RequestState.error,
              movieSearchMessage: l.message
            )),
            (r) => emit(state.copyWith(
              movieSearchList:r ,
              movieSearchState:RequestState.loaded
            ))
    );
  }

  FutureOr<void> _tvSearch(TvSearchEvent event, Emitter<AppSettingState> emit) async {
    final result=await getTvSearchUseCase(event.query);
    result.fold(
            (l) => emit(
            state.copyWith(
                tvSearchState: RequestState.error,
                tvSearchMessage: l.message
            )),
            (r) => emit(state.copyWith(
            tvSearchList:r ,
            tvSearchState:RequestState.loaded
        ))
    );
  }
}
