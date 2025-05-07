import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/services_locator.dart';

import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/presentation/components/movie_details_content_component.dart';
import 'package:movies_app/movies/presentation/components/review_component.dart';
import 'package:movies_app/settings/presentation/controller/app_setting_bloc.dart';
import 'package:movies_app/movies/presentation/controller/movie_detail_bloc.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../controller/movie_detail_event.dart';
import '../controller/movie_detail_state.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;
  PanelController panelController =PanelController();
   bool Opened=false;

  MovieDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieDetailBloc>()
        ..add(GetMovieDetailEvent(id: id))
        ..add(GetRecommendationMoviesEvent(id: id))
        ..add(GetTrailerMoviesEvent(id: id))..add(GetReviewsMoviesEvent(id: id)),
      //lazy: false,
      child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) =>  Scaffold(
          body: SlidingUpPanel(padding: const EdgeInsets.symmetric(vertical: 5),
            controller: panelController,
              body: ConditionalBuilder(
                condition:state.movieDetail!=null&&state.trailerMovieState==RequestState.loaded&&state.recommendationState==RequestState.loaded ,
                  builder:(context) =>  const MovieDetailsContentComponent() ,
                  fallback:(context) => const Center(child: CircularProgressIndicator()),

              ),
            color:BlocProvider.of<AppSettingBloc>(context).isDark? Colors.black87:Colors.white70,
            minHeight:MediaQuery.of(context).size.height*0.07 ,
            maxHeight: MediaQuery.of(context).size.height*0.8,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            parallaxEnabled:true ,
            parallaxOffset: 0.55,
            panelBuilder: (sc){
                return  ListView(
                  padding: EdgeInsets.zero,
                  controller: sc,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    GestureDetector(
                        onTap:()=>togglePanel(panelController),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 110,vertical: 5),
                          child: Center(
                            child: Container(
                              height: 3.5,width:double.infinity,
                              decoration: BoxDecoration(
                                  color:BlocProvider.of<AppSettingBloc>(context).isDark? Colors.grey:Colors.black,
                                  borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                          ),
                        )
                    ),
                     Center(child: Text("Reviews",style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),)),
                    const ReviewComponent(),
                  ],
                );
            } ,
          ),
        ),
      ),
    );
  }
  void togglePanel(PanelController panelController){
    if(Opened==false){
      panelController.open();
    }else{
      panelController.close();
    }

  }

}


