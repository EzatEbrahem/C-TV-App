import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/movies/presentation/components/see_more_component.dart';

import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums.dart';
import '../controller/movie_bloc.dart';

class TopRatedSeeMoreScreen extends StatelessWidget {
  const TopRatedSeeMoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieBloc>()
        ..add(GetTopRatedMoviesEvent()),
      lazy: false,
      child: Scaffold(
            appBar: AppBar(centerTitle:true , title: Text('Top Rated Movies',style: Theme.of(context).textTheme.bodyMedium,),),
            body:BlocBuilder<MovieBloc,MovieState>(
                builder:(context,state) {
                  switch(state.topRatedState){
                    case RequestState.loading:
                      return const Center(child: CircularProgressIndicator());
                    case RequestState.loaded:
                      return  ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              SeeMoreComponent(movie: state.topRatedMovies[index]),
                          separatorBuilder: (context, index) =>
                          const SizedBox(height: 0,),
                          itemCount: state.topRatedMovies.length);
                    case RequestState.error:
                      return Center(child: Text(state.topRatedMessage));

                  }
                }),

      ),

    );
  }
}
