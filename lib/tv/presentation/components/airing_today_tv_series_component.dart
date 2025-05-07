import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_states.dart';
import 'package:movies_app/tv/presentation/screens/tv_series_detail_screen.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/utils/enums.dart';

class AiringTodayTvSeriesComponent extends StatelessWidget {
  const AiringTodayTvSeriesComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height/2.9;
    return BlocBuilder<TvSeriesBloc,TvSeriesState>(
      buildWhen:(previous, current) => previous.airingTodayTvSeriesState!=current.airingTodayTvSeriesState  ,
        builder: (BuildContext context, TvSeriesState state) {
        switch(state.airingTodayTvSeriesState){
          case RequestState.loading:
            return  SizedBox(
              height: height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          case RequestState.loaded:
            return CarouselSlider(
              options: CarouselOptions(
                height: height,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                viewportFraction: 1.0,
                pageSnapping: true,
                autoPlayCurve:Curves.easeInOut ,
                scrollPhysics: const BouncingScrollPhysics(),
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                autoPlayAnimationDuration:const Duration(milliseconds:900 ) ,
                autoPlayInterval: const Duration(seconds:2 ),
                reverse: false,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {},
              ),
              items: state.airingTodayTvSeries.map(
                    (item) {
                  return GestureDetector(
                    key: const Key('openMovieMinimalDetail'),
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            TvSeriesDetailScreen(
                              id: item.id,
                            ),
                      ),
                    );
                    },
                    child: Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (rect) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                // fromLTRB
                                Colors.transparent,
                                Colors.black,
                                Colors.black,
                                Colors.transparent,
                              ],
                              stops: [0, 0.2, 0.5, 1],
                            ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height),
                            );
                          },
                          blendMode: BlendMode.dstIn,
                          child: CachedNetworkImage(
                            height: height,
                            imageUrl: ApiConstance.imageUrl(item.backdropPath),
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.redAccent,
                                      size: 16.0,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      'Airing Today'.toUpperCase(),
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  item.name,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 25,fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            );
          case RequestState.error:
            return SizedBox(
              height: height,
              child: Center(
                child: Text(state.airingTodayTvSeriesMessage),
              ),
            );
        }

        },

    );


  }
}
