import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tv/presentation/components/tv_series_episode_component.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_details_events.dart';
import 'package:movies_app/tv/utils/tv_series_parameter_id.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums.dart';
import '../../domain/entities/tv_series_details.dart';
import '../controller/tv_series_details_bloc.dart';
import '../controller/tv_series_details_states.dart';


class TvSeriesEpisodesScreen extends StatelessWidget {
  final TvSeriesDetails? tvSeriesDetails;
  final int seasonNum;
  const TvSeriesEpisodesScreen({Key? key, required this.tvSeriesDetails, required this.seasonNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>sl<TvSeriesDetailsBloc>()..add(GetTvSeriesEpisodeEvent(TvSeriesIdParameter(tvSeriesId: tvSeriesDetails!.id,seasonNumber: seasonNum))),
      child: Scaffold(
            appBar: AppBar( centerTitle:true , title: Text('Episodes',style: Theme.of(context).textTheme.bodyMedium,)),
            body: BlocBuilder<TvSeriesDetailsBloc,TvSeriesDetailsState>(
              buildWhen: (previous, current) => previous.tvSeriesEpisodesState!=current.tvSeriesEpisodesState,
              builder:(context,state) {
                switch(state.tvSeriesEpisodesState){
                  case RequestState.loading:
                    return const Center(child: CircularProgressIndicator());
                  case RequestState.loaded:
                   return  ListView.separated(
                       physics: const BouncingScrollPhysics(),
                       itemBuilder: (context, index) =>
                           TvSeriesEpisodesComponent( tvSeriesEpisode: state.tvSeriesEpisodes[index],
                               tvSeriesDetails: tvSeriesDetails),
                       separatorBuilder: (context, index) =>
                       const SizedBox(height: 0,),
                       itemCount: state.tvSeriesEpisodes.length);
                  case RequestState.error:
                    return Center(child: Text(state.tvSeriesEpisodesMessage));

              }
              }),

      ),
    );
  }
}
