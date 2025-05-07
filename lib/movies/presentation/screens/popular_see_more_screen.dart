import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/movies/presentation/components/see_more_component.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums.dart';
import '../controller/movie_bloc.dart';
import '../controller/movie_event.dart';
import '../controller/movie_state.dart';

class PopularSeeMoreScreen extends StatelessWidget {
  const PopularSeeMoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieBloc>()
        ..add(GetPopularMoviesEvent()),
      lazy: false,
      child:Scaffold(
            appBar: AppBar( centerTitle:true , title: Text('Popular Movies',style: Theme.of(context).textTheme.bodyMedium,)),
            body: BlocBuilder<MovieBloc,MovieState>(
              builder:(context,state) {
                switch(state.popularState){
                  case RequestState.loading:
                    return const Center(child: CircularProgressIndicator());
                  case RequestState.loaded:
                   return  ListView.separated(
                       physics: const BouncingScrollPhysics(),
                       itemBuilder: (context, index) =>
                           SeeMoreComponent(movie: state.popularMovies[index]),
                       separatorBuilder: (context, index) =>
                       const SizedBox(height: 0,),
                       itemCount: state.popularMovies.length);
                  case RequestState.error:
                    return Center(child: Text(state.popularMessage));

              }
              }),

      ),

    );
  }
}
