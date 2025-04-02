import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/movies/presentation/controller/movie_detail_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/utils/enums.dart';

class TrailerComponent extends StatelessWidget {
  const TrailerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc,MovieDetailState>(
      buildWhen: (previous, current)=>previous.trailerMovieState!=current.trailerMovieState,
      builder:(context,state){
        switch(state.trailerMovieState){
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestState.loaded:
            final YoutubePlayerController controller= YoutubePlayerController(
                initialVideoId: state.trailerMovie!.key,
                flags: const YoutubePlayerFlags(autoPlay: false)
            );
            return ConditionalBuilder(
              condition:state.trailerMovie?.key!="" ,
              builder:(context)=>YoutubePlayer(controller: controller,
                showVideoProgressIndicator:true,
                progressIndicatorColor: Colors.amber,
                bottomActions:[
                  CurrentPosition(),
                  ProgressBar(
                      isExpanded:true,
                      colors:const ProgressBarColors(
                        playedColor: Colors.amber,
                        handleColor: Colors.amberAccent,
                      )),
                  RemainingDuration(),
                  const PlaybackSpeedButton(),


                ],) ,
              fallback:(context)=>const Center(child: Text("Not Founded",style: TextStyle(color: Colors.redAccent),)) ,
            );
          case RequestState.error:
            return Center(child: Text(state.trailerMovieMessage),);
        }
      } ,

    );
  }
}
