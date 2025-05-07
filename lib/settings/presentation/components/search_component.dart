import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/movies/presentation/screens/movie_detail_screen.dart';
import 'package:movies_app/settings/presentation/controller/app_setting_bloc.dart';
import 'package:movies_app/tv/presentation/screens/tv_series_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constance.dart';
import '../../../core/utils/enums.dart';
import '../controller/app_setting_state.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<AppSettingBloc,AppSettingState>(
      builder: (context, state) {
        if(state.currentIndex==0){
          switch(state.movieSearchState) {
            case RequestState.loading:
              return const SliverToBoxAdapter(child: Center(child:Image(image: AssetImage("assets/search1.png"))));
            case RequestState.loaded:
              if(state.movieSearchList.isEmpty){
                return const SliverToBoxAdapter(child: Center(child:Image(image: AssetImage("assets/search1.png"))));
              }
              return SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    childCount: state.movieSearchList.length,
                    (context, index) {
                  final movie = state.movieSearchList[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10, top: 10),
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
                                    MovieDetailScreen(id: movie.id,
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
                                    height: 130,
                                    fit: BoxFit.fill,
                                    imageUrl: ApiConstance.imageUrl(
                                        movie.backdropPath),
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey[850]!,
                                      highlightColor: Colors.grey[800]!,
                                      child: Container(
                                        width: 180,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5,left: 8,right: 8),
                                      child: Text(movie.title,
                                          style: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2),
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
                }),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                ),
              );
            case RequestState.error:
              return  SliverToBoxAdapter(child: Center(child: Text(state.movieSearchMessage)));
          }
        }
        else{
          switch(state.tvSearchState) {
            case RequestState.loading:
              return const SliverToBoxAdapter(child: Center(child:Image(image: AssetImage("assets/search1.png"))));
            case RequestState.loaded:
              if(state.tvSearchList.isEmpty){
                return const SliverToBoxAdapter(child: Center(child:Image(image: AssetImage("assets/search1.png"))));
              }
              return SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    childCount: state.tvSearchList.length,
                        (context, index) {
                      final tv = state.tvSearchList[index];
                      return Padding(
                        padding:
                        const EdgeInsets.only(left: 10.0, right: 10, top: 10),
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
                                        TvSeriesDetailScreen(id: tv.id,
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
                                        height: 130,
                                        fit: BoxFit.fill,
                                        imageUrl: ApiConstance.imageUrl(
                                            tv.backdropPath),
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                              baseColor: Colors.grey[850]!,
                                              highlightColor: Colors.grey[800]!,
                                              child: Container(
                                                width: 180,
                                                height: 130,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                  BorderRadius.circular(8.0),
                                                ),
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5,left: 8,right: 8),
                                          child: Text(tv.name,
                                              style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2),
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
                    }),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                ),
              );
            case RequestState.error:
              return  SliverToBoxAdapter(child: Center(child: Text(state.tvSearchMessage)));
          }

        }

      },

    );
  }
}
