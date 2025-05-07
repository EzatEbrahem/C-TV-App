import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_details_bloc.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_details_states.dart';
import '../controller/tv_series_details_events.dart';

class ToggleButtonComponent extends StatelessWidget {
  const ToggleButtonComponent({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<TvSeriesDetailsBloc,TvSeriesDetailsState>(
      buildWhen: (previous, current) => previous.currentIndex!=current.currentIndex,
     builder: (context, state){
        return  SliverPadding(
  padding: const EdgeInsets.symmetric(vertical: 20),
  sliver: SliverToBoxAdapter(
    child: Center(
      child: ToggleButtons(
        borderWidth:2 ,textStyle:const TextStyle(fontStyle: FontStyle.italic,fontSize: 15) ,
        borderColor:Colors.black ,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        selectedBorderColor: Colors.blueGrey,
        selectedColor: Colors.white70,
        fillColor: Colors.black,
        color: Colors.grey,
        constraints: const BoxConstraints(minHeight: 40.0, minWidth: 80.0),
        onPressed: (int index){

          BlocProvider.of<TvSeriesDetailsBloc>(context).add(NavigateBetweenListEvent( index,state.show));
        },
        isSelected: state.selectedButton,
        children: const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('Recommendations'),
          ),Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('Seasons'),
          )
        ],),
    ),
  ),
);
     },
    );
  }
}
