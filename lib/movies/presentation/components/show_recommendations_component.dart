import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constance.dart';
import '../../../core/utils/enums.dart';
import '../controller/movie_detail_bloc.dart';
import '../controller/movie_detail_state.dart';
import '../screens/movie_detail_screen.dart';

class ShowRecommendationsComponent extends StatelessWidget {
  const ShowRecommendationsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final height=size.height;
    final width=size.height;
    return  BlocBuilder<MovieDetailBloc, MovieDetailState>(
      buildWhen: (previous, current) => current.recommendationState!=previous.recommendationState,
      builder: (context, state) {
        switch(state.recommendationState){
          case RequestState.loading:
           return const Center(child: CircularProgressIndicator());
          case RequestState.loaded:
            return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final recommendation = state.recommendation[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => MovieDetailScreen(
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
                          imageUrl:
                          ApiConstance.imageUrl(recommendation.backdropPath!),
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[850]!,
                            highlightColor: Colors.grey[800]!,
                            child: Container(
                              height: height/5,
                              width: width/3,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                          height: height/5,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
                childCount: state.recommendation.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 0.7,
                crossAxisCount: 3,
              ),
            );
          case RequestState.error:
           return Center(child: Text(state.recommendationMessage));
        }
      }
    );
  }
}
