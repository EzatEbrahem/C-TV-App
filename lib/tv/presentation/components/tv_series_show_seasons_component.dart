import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_details_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_details_states.dart';
import 'package:movies_app/tv/presentation/screens/tv_series_episodes_screen.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/utils/enums.dart';

class TvSeriesShowSeasonsComponents extends StatelessWidget {

  const TvSeriesShowSeasonsComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<TvSeriesDetailsBloc,TvSeriesDetailsState>(
      buildWhen:(previous, current) => previous.tvSeriesDetailsState!=current.tvSeriesDetailsState ,
      builder: (context, state) {
        switch(state.tvSeriesDetailsState) {
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestState.loaded:
            return SliverGrid(
              delegate:  SliverChildBuilderDelegate(
                childCount: state.tvSeriesDetails?.seasons.length,
                      (context, index){
                        final seasons = state.tvSeriesDetails?.seasons[index];

                       return Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                child: ClipRRect(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    color: Colors.black26,
                    child: InkWell(
                      onTap: () {
                       Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          TvSeriesEpisodesScreen(
                             tvSeriesDetails: state.tvSeriesDetails, seasonNum: seasons!.seasonNumber,
                          ),
                    ),
                  );
                      },
                      child: ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8.0)),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(8)),
                              child: CachedNetworkImage(
                                width: 180,
                                height: 110,
                                fit: BoxFit.fill,
                                imageUrl: ApiConstance.imageUrl(
                                    seasons!.posterPath),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[850]!,
                                      highlightColor: Colors.grey[800]!,
                                      child: Container(
                                        width: 180,
                                        height: 110,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(
                                              8.0),
                                        ),
                                      ),
                                    ),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Text(
                                      seasons.name,
                                      style: const TextStyle(fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius
                                              .circular(4.0),
                                          child: Container(
                                            color: Colors.red,
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .only(left: 9.0,
                                                  right: 9,
                                                  top: 3,
                                                  bottom: 3),
                                              child: Text(
                                                seasons
                                                    .airDate.substring(
                                                    0, 4),
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight
                                                        .bold),),
                                            ),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0),
                                          child: Row(
                                              children: [
                                                const Icon(Icons.live_tv,
                                                    color: Colors.brown,
                                                    size: 25),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(left: 5.0),
                                                  child: Text(
                                                    "${seasons.episodeCount}",
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                    .titleSmall,),
                                                ),
                                              ]),
                                        ),

                                      ]),
                                ),

                              ],
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
              }
              ),
              gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 1,

              ),

            );

          case RequestState.error:
        return Center(child: Text(state.tvSeriesRecommendationsMessage));
        }

      },

    );
  }
}
