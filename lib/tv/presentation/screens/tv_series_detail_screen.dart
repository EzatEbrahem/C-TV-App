import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/settings/presentation/controller/app_setting_bloc.dart';
import 'package:movies_app/tv/presentation/components/tv_series_details_component.dart';
import 'package:movies_app/tv/presentation/components/tv_series_review_component.dart';
import 'package:movies_app/tv/utils/tv_series_parameter_id.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../controller/tv_series_details_bloc.dart';
import '../controller/tv_series_details_events.dart';
import '../controller/tv_series_details_states.dart';

class TvSeriesDetailScreen extends StatelessWidget {
  final int id;
  PanelController panelController =PanelController();
  bool Opened=false;

  TvSeriesDetailScreen({Key? key,  required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TvSeriesDetailsBloc>()
        ..add(GetTvSeriesDetailsEvent(TvSeriesIdParameter(tvSeriesId: id) ))
        ..add(GetTvSeriesRecommendationsEvent(TvSeriesIdParameter(tvSeriesId: id)))
        ..add(GetTvSeriesReviewsEvent(TvSeriesIdParameter(tvSeriesId: id)))
      ..add(const NavigateBetweenListEvent(0,false)),
      //lazy: false,
      child: BlocBuilder<TvSeriesDetailsBloc, TvSeriesDetailsState>(
        builder: (context, state) =>  Scaffold(
          body: SlidingUpPanel(padding: const EdgeInsets.symmetric(vertical: 5),
            controller: panelController,
            body: ConditionalBuilder(
              condition:state.tvSeriesDetailsState==RequestState.loaded&&state.tvSeriesRecommendationsState==RequestState.loaded ,
              builder:(context) =>  const TvSeriesDetailsComponent() ,
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
                  const TvSeriesReviewComponent(),
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


