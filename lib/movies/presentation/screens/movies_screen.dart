import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/presentation/components/now_playing_component.dart';
import 'package:movies_app/movies/presentation/components/popular_component.dart';
import 'package:movies_app/movies/presentation/components/top_rated_component.dart';
import 'package:movies_app/movies/presentation/controller/movie_bloc.dart';
import 'package:movies_app/movies/presentation/controller/movie_state.dart';
import 'package:movies_app/movies/presentation/screens/popular_see_more_screen.dart';
import 'package:movies_app/movies/presentation/screens/top_rated_see_more_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/services/services_locator.dart';
import '../controller/movie_event.dart';

class MainMoviesScreen extends StatelessWidget {
  const MainMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<MovieBloc>()
        ..add(GetNowPlayingMoviesEvent())
        ..add(GetPopularMoviesEvent())
        ..add(GetTopRatedMoviesEvent()),
      child: const _MainMoviesView(),
    );
  }
}
class _MainMoviesView extends StatelessWidget {
  const _MainMoviesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieBloc,MovieState>(
      listenWhen: (previous,current)=>previous.connectionState!=current.connectionState||previous.reloadMovieScreenState!=current.reloadMovieScreenState,
      listener: (BuildContext context, MovieState state) {
        if(state.connectionState==ConnectState.local){
          showTopSnackBar(
            Overlay.of(context),
             const CustomSnackBar.info(
              backgroundColor:Colors.black,
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
              onRefresh: () async {
                final completer = Completer();
              final subscription = context.read<MovieBloc>().stream.listen((state) {
                if (state.reloadMovieScreenState == RequestState.loaded) {
                  completer.complete();
                }
              });
              context.read<MovieBloc>().add(ReloadDataMoviesEvent());
              await completer.future;
              await subscription.cancel();
              },
              child:SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                key: const Key('movieScrollView'),
                child:
                  Column(
                    children: [
                      const NowPlayingComponent(),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Popular",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const PopularSeeMoreScreen()),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text('See More', style: Theme.of(context).textTheme.titleSmall),
                                    const Icon(Icons.arrow_forward_ios, size: 16.0),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const PopularComponent(),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Top Rated", style: Theme.of(context).textTheme.bodyMedium),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const TopRatedSeeMoreScreen()),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text('See More', style: Theme.of(context).textTheme.titleSmall),
                                    const Icon(Icons.arrow_forward_ios, size: 16.0),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const TopRatedComponent(),
                    ]),
                  ),

              ),


          ),
    );
  }
}
