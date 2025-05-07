import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_states.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constance.dart';
import '../../../core/utils/enums.dart';
import '../screens/tv_series_detail_screen.dart';

class TopRatedTvSeriesComponent extends StatelessWidget {
  const TopRatedTvSeriesComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height/4.6;
    final width = size.width/3.3;
    return BlocBuilder<TvSeriesBloc,TvSeriesState>(
      buildWhen: (previous, current) => previous.topRatedTvSeriesState!=current.topRatedTvSeriesState,
      builder: (BuildContext context, TvSeriesState state) {
        switch(state.topRatedTvSeriesState) {
          case RequestState.loading:
            return  SizedBox(
              height:height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          case RequestState.loaded:
            return FadeIn(
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                height: height,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: state.topRatedTvSeries.length,
                  itemBuilder: (context, index) {
                    final tv = state.topRatedTvSeries[index];
                    return Container(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                TvSeriesDetailScreen(
                                  id: tv.id,
                                ),
                          ),
                        );
                        },
                        child: ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                          child: CachedNetworkImage(
                            width: width,
                            fit: BoxFit.fill,
                            imageUrl: ApiConstance.imageUrl(tv.backdropPath),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[850]!,
                              highlightColor: Colors.grey[800]!,
                              child: Container(
                                height: height,
                                width: width,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          case RequestState.error:
            return SizedBox(
              height: height,
              child: Center(
                child: Text(state.popularTvSeriesMessage),
              ),
            );
        }
      },);


  }
}
