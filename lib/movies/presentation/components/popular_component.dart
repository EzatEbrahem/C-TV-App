import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/movies/presentation/controller/movie_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constance.dart';
import '../../../core/utils/enums.dart';
import '../controller/movie_state.dart';
import '../screens/movie_detail_screen.dart';

class PopularComponent extends StatelessWidget {
  const PopularComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height/4.6;
    final width = size.width/3.3;
    return  BlocBuilder<MovieBloc,MovieState>(
      buildWhen:(previous, current)=>previous.popularState!=current.popularState,
      builder: (context,state){
        switch(state.popularState){

          case RequestState.loading:
            return  SizedBox(
              height: height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          case RequestState.loaded:
           return  FadeIn(
             duration: const Duration(milliseconds: 500),
             child: SizedBox(
               height: height,
               child: ListView.builder(
                 physics: const BouncingScrollPhysics(),
                 shrinkWrap: true,
                 scrollDirection: Axis.horizontal,
                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
                 itemCount: state.popularMovies.length,
                 itemBuilder: (context, index) {
                   final movie =  state.popularMovies[index];
                   return Container(
                     padding: const EdgeInsets.only(right: 8.0),
                     child: InkWell(
                       onTap: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (BuildContext context) =>
                                 MovieDetailScreen(
                                   id:  movie.id,
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
                           imageUrl: ApiConstance.imageUrl(movie.backdropPath!),
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
                child: Text(state.nowPlayingMessage),
              ),
            );
        }
      },

    );
  }
}
