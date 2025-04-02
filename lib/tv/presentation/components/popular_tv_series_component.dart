import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_states.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constance.dart';
import '../../../core/utils/enums.dart';
import '../screens/tv_series_detail_screen.dart';

class PopularTvSeriesComponent extends StatelessWidget {
  const PopularTvSeriesComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSeriesBloc,TvSeriesState>(
      buildWhen:(previous, current) => previous.popularTvSeriesState!=current.popularTvSeriesState,
      builder: (BuildContext context, TvSeriesState state) {
        switch(state.popularTvSeriesState) {
          case RequestState.loading:
            return const SizedBox(
              height: 170.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case RequestState.loaded:
           return  FadeIn(
             duration: const Duration(milliseconds: 500),
             child: SizedBox(
               height: 170.0,
               child: ListView.builder(
                 physics: const BouncingScrollPhysics(),
                 shrinkWrap: true,
                 scrollDirection: Axis.horizontal,
                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
                 itemCount: state.popularTvSeries.length,
                 itemBuilder: (context, index) {
                   final tv = state.popularTvSeries[index];
                   return Container(
                     padding: const EdgeInsets.only(right: 8.0),
                     child: InkWell(
                       onTap: () {
                         Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (BuildContext context) =>
                               TvSeriesDetailScreen(
                                 id:tv.id,
                               ),
                         ),
                       );
                       },
                       child: ClipRRect(
                         borderRadius:
                         const BorderRadius.all(Radius.circular(8.0)),
                         child: CachedNetworkImage(
                           width: 120.0,
                           fit: BoxFit.fill,
                           imageUrl: ApiConstance.imageUrl(tv.backdropPath),
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
              height: 170.0,
              child: Center(
                child: Text(state.popularTvSeriesMessage),
              ),
            );
        }
      }

    );


  }
}
