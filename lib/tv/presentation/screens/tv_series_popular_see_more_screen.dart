import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_events.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_states.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums.dart';
import '../components/tv_series_see_more_component.dart';


class PopularSeeMoreTvSeriesScreen extends StatelessWidget {
  const PopularSeeMoreTvSeriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TvSeriesBloc>()
        ..add(GetPopularTvSeriesEvent()),
      lazy: false,
      child:Scaffold(
            appBar: AppBar( centerTitle:true , title: Text('Popular Series',style: Theme.of(context).textTheme.bodyMedium,)),
            body: BlocBuilder<TvSeriesBloc,TvSeriesState>(
              builder:(context,state) {
                switch(state.popularTvSeriesState){
                  case RequestState.loading:
                    return const Center(child: CircularProgressIndicator());
                  case RequestState.loaded:
                   return  ListView.separated(
                       physics: const BouncingScrollPhysics(),
                       itemBuilder: (context, index) =>
                           TvSeriesSeeMoreComponent(tvSeries: state.popularTvSeries[index]),
                       separatorBuilder: (context, index) =>
                       const SizedBox(height: 0,),
                       itemCount: state.popularTvSeries.length);
                  case RequestState.error:
                    return Center(child: Text(state.popularTvSeriesMessage));

              }
              }),

      ),

    );
  }
}
