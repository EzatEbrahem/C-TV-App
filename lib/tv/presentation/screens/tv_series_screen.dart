import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tv/presentation/components/airing_today_tv_series_component.dart';
import 'package:movies_app/tv/presentation/components/popular_tv_series_component.dart';
import 'package:movies_app/tv/presentation/components/top_rated_tv_series_component.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_events.dart';
import 'package:movies_app/tv/presentation/screens/tv_series_popular_see_more_screen.dart';
import 'package:movies_app/tv/presentation/screens/tv_series_top_rated_see_more_screen.dart';

import '../../../core/services/services_locator.dart';

class TvSeriesScreen extends StatelessWidget {
  const TvSeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => sl<TvSeriesBloc>()
        ..add(GetAiringTodayTvSeriesEvent())
        ..add(GetTopRatedTvSeriesEvent())
        ..add(GetPopularTvSeriesEvent()),
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AiringTodayTvSeriesComponent(),
              Container(
                margin:  const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
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
                  24.0,
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
    );
  }
}
