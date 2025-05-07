import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_details_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_details_states.dart';
import 'package:movies_app/tv/presentation/screens/tv_series_detail_screen.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/utils/enums.dart';


class TvSeriesRecommendationsComponent extends StatelessWidget {
  const TvSeriesRecommendationsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<TvSeriesDetailsBloc, TvSeriesDetailsState>(
        buildWhen: (previous, current) =>
        current.tvSeriesRecommendationsState!=previous.tvSeriesRecommendationsState,
        builder: (context, state) {
          switch(state.tvSeriesRecommendationsState){
            case RequestState.loading:
              return const Center(child: CircularProgressIndicator());
            case RequestState.loaded:
              return SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final recommendation = state.tvSeriesRecommendations[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => TvSeriesDetailScreen(
                              id: recommendation.id,
                            ),
                          ),
                        );
                      },
                      child: FadeInUp(
                        from: 20,
                        duration: const Duration(milliseconds: 500),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                          child: CachedNetworkImage(
                              fit: BoxFit.fill,
                            imageUrl:
                            ApiConstance.imageUrl(recommendation.backdropPath!),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[850]!,
                              highlightColor: Colors.grey[800]!,
                              child: Container(
                                height: 170.0,
                                width: 120.0,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                            height: 180.0,

                          ),
                        ),
                      ),
                    );
                  },
                  childCount: state.tvSeriesRecommendations.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 0.7,
                  crossAxisCount: 3,
                ),
              );
            case RequestState.error:
              return Center(child: Text(state.tvSeriesRecommendationsMessage));
          }
        }
    );
  }
}
