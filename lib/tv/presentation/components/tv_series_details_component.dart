import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tv/presentation/components/toggle_buttons_component.dart';
import 'package:movies_app/tv/presentation/components/tv_series_recommendations_component.dart';
import 'package:movies_app/tv/presentation/components/tv_series_show_seasons_component.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_details_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_details_states.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/utils/enums.dart';



class TvSeriesDetailsComponent extends StatelessWidget {
  const TvSeriesDetailsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final height=size.height;
    return BlocBuilder<TvSeriesDetailsBloc, TvSeriesDetailsState>(
      buildWhen: (previous, current) =>
      current.tvSeriesDetailsState!=previous.tvSeriesDetailsState||current.show!=previous.show,
      builder: (context, state) {
        switch(state.tvSeriesDetailsState){
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestState.loaded:

            return CustomScrollView(
              key: const Key('tvDetailScrollView'),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: height*0.3,
                  flexibleSpace: FlexibleSpaceBar(
                    background: FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black,
                              Colors.black,
                              Colors.transparent,
                            ],
                            stops: [0.0, 0.3, 1.0, 1.0],
                          ).createShader(
                            Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                          );
                        },
                        blendMode: BlendMode.dstIn,
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width,
                          imageUrl: ApiConstance.imageUrl(
                              state.tvSeriesDetails!.backdropPath!),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: FadeInUp(
                    from: 20,
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(state.tvSeriesDetails!.name,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.5,

                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2.0,
                                    horizontal: 8.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child:Text('First air date: ${state.tvSeriesDetails!.firstAirDate.split('-')[0]}',
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                  ),
                                const SizedBox(width: 20.0),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 23.0,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      (state.tvSeriesDetails!.voteAverage / 2)
                                          .toStringAsFixed(1),
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                      ),
                                    ),


                                  ],
                                ),
                                const SizedBox(width: 18.0),
                                const Icon(Icons.access_time_outlined,size: 20,),
                                const SizedBox(width: 4.0),
                                Text(
                                  _showDuration(state.tvSeriesDetails!.episodeRunTime ),
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2.0,
                                horizontal: 8.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child:Text('Last air date: ${state.tvSeriesDetails!.lastAirDate.split('-')[0]}',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom:8.0),
                            child: Text(

                              state.tvSeriesDetails!.overview,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 14.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          Text(
                            '${"type"}: ${state.tvSeriesDetails!.type}',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.grey[600],
                              fontSize: 12.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            '${"Number of seasons"}: ${state.tvSeriesDetails!.numberOfSeasons}',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.grey[600],
                              fontSize: 12.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            '${"Number of episodes"}: ${state.tvSeriesDetails!.numberOfEpisodes}',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.grey[600],
                              fontSize: 12.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                const ToggleButtonComponent(),
                if(state.show)
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(0.0, 5.0,0.0, 15.0),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        "More Like This",
                        style:Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
                if(state.show)
                const SliverPadding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 55.0),
                  sliver: TvSeriesRecommendationsComponent(),
                ),
                if(!state.show)
                 SliverPadding(
                    padding: const EdgeInsets.fromLTRB(0.0, 5.0,0.0, 15.0),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          "Seasons",
                          style:Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                if(!state.show)
                  const SliverPadding(
                    padding: EdgeInsets.fromLTRB(3.0, 0, 4.0, 55.0),
                  sliver: TvSeriesShowSeasonsComponents(),
                )
              ],
            );
          case RequestState.error:
            return  Center(child: Text(state.tvSeriesDetailsMessage));
        }

      },
    );

  }

  String _showDuration(List<int> runtime) {
    if(runtime.isNotEmpty){
    final int hours = runtime[0] ~/ 60;
    final int minutes = runtime[0] % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }else{
      return'0';
    }
  }

}
