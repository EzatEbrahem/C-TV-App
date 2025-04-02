import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_details_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_details_states.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constance.dart';
import '../../../core/utils/enums.dart';

class LastNextTvSeriesComponent extends StatelessWidget {
  final String lastOrLast;
  final int numOfE;
  final int numOfS;

  const LastNextTvSeriesComponent({super.key, required this.lastOrLast, required this.numOfE, required this.numOfS});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSeriesDetailsBloc, TvSeriesDetailsState>(
      buildWhen: (previous, current) =>
          previous.tvSeriesDetailsState != current.tvSeriesDetailsState,
      builder: (BuildContext context, TvSeriesDetailsState state) {
        switch (state.tvSeriesDetailsState) {
          case RequestState.loading:
            return const SizedBox(
              height: 170.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case RequestState.loaded:
            return Stack(
              children: [
                FadeInUp(
                  from: 20,
                  duration: const Duration(milliseconds: 500),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    child: CachedNetworkImage(
                      imageUrl:
                          ApiConstance.imageUrl(state.tvSeriesDetails!.backdropPath!),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[850]!,
                        highlightColor: Colors.grey[800]!,
                        child: Container(
                          height: 150.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      height: 100.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.yellow,
                    child:  Center(
                        child: Text('E $numOfE',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 5,
                                fontStyle: FontStyle.italic))),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.yellow,
                    child:  Center(
                        child: Text('S $numOfS',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 5,
                                fontStyle: FontStyle.italic))),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.redAccent,
                              size: 5.0,
                            ),
                            const SizedBox(width: 0.0),
                            Text(
                              lastOrLast.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontSize: 5, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: Text(
                          lastOrLast,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          case RequestState.error:
            return SizedBox(
              height: 170.0,
              child: Center(
                child: Text(state.tvSeriesDetailsMessage),
              ),
            );
        }
      },
    );
  }
}
