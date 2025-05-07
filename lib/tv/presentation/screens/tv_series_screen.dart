import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tv/presentation/components/airing_today_tv_series_component.dart';
import 'package:movies_app/tv/presentation/components/popular_tv_series_component.dart';
import 'package:movies_app/tv/presentation/components/top_rated_tv_series_component.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_events.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_states.dart';
import 'package:movies_app/tv/presentation/screens/tv_series_popular_see_more_screen.dart';
import 'package:movies_app/tv/presentation/screens/tv_series_top_rated_see_more_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums.dart';

class TvSeriesScreen extends StatelessWidget {
  const TvSeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => sl<TvSeriesBloc>()
        ..add(GetAiringTodayTvSeriesEvent())
        ..add(GetTopRatedTvSeriesEvent())
        ..add(GetPopularTvSeriesEvent()),
      child:const _TvSeriesScreen(),
    );
  }
}
class _TvSeriesScreen extends StatelessWidget {
  const _TvSeriesScreen();

  @override
  Widget build(BuildContext context) {
    return  BlocListener<TvSeriesBloc,TvSeriesState>(
      listenWhen: (previous,current)=>previous.connectionState!=current.connectionState||previous.reloadTvSeriesScreenState!=current.reloadTvSeriesScreenState,
      listener: (BuildContext context, TvSeriesState state) {
        if(state.connectionState==ConnectState.local){
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.info( backgroundColor:Colors.black,
              message:
              "No internet connection, Check your internet",
            ),
          );
        }
      },
      child: Scaffold(
        body: RefreshIndicator(
          color:Theme.of(context).primaryColor ,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          strokeWidth: 3.5,
          displacement: 50,
          onRefresh: () async{
            final completer = Completer();
            final subscription = context.read<TvSeriesBloc>().stream.listen((state) {
              if (state.reloadTvSeriesScreenState == RequestState.loaded) {
                completer.complete();
              }
            });
            context.read<TvSeriesBloc>().add(ReloadDataTvSeriesEvent());
            await completer.future;
            await subscription.cancel();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AiringTodayTvSeriesComponent(),
                Container(
                  margin:  const EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context)=> const PopularSeeMoreTvSeriesScreen()));

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children:  [
                              Text('See More' ,style:Theme.of(context).textTheme.titleSmall),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const PopularTvSeriesComponent(),
                Container(
                  margin: const EdgeInsets.fromLTRB(
                    16.0,
                    16.0,
                    16.0,
                    8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Rated",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context)=> const TopRatedSeeTvSeriesMoreScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children:  [
                              Text('See More',style:Theme.of(context).textTheme.titleSmall),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const TopRatedTvSeriesComponent(),
                //const SizedBox(height: 50.0),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

