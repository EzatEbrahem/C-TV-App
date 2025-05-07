
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/settings/presentation/controller/app_setting_bloc.dart';
import 'package:movies_app/settings/presentation/screens/search_screen.dart';

import '../controller/app_setting_event.dart';
import '../controller/app_setting_state.dart';

final TextEditingController searchController = TextEditingController();
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final width=size.width;
    return BlocBuilder<AppSettingBloc, AppSettingState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: state.items,
          currentIndex:state.currentIndex ,
          onTap: (index){
              BlocProvider.of<AppSettingBloc>(context).add(NavigateScreenEvent(index: index));
          },),
            floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
          floatingActionButton:
              Stack(children: [
                Positioned(
                  bottom:0,
                  width: width*0.155,
                  height: width*0.155,
                  left: width/2.35,

                  child: FloatingActionButton(
                      heroTag: "theme",
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50) ),
                      onPressed:(){BlocProvider.of<AppSettingBloc>(context).add(const ChangeModeEvent());},
                      child: const Icon(Icons.light_mode_rounded)),
                ),
                Positioned(
                  top: 250,
                  width: width*0.12,
                  height: width*0.12,
                  left: 2,
                  child: FloatingActionButton(
                      heroTag: "search",
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50) ),
                      onPressed:(){
                        if(state.currentIndex==0){
                          BlocProvider.of<AppSettingBloc>(context)
                              .add(const MovieSearchEvent(query: ''));
                        }else{
                          BlocProvider.of<AppSettingBloc>(context)
                              .add(const TvSearchEvent(query: ''));
                        }
                        searchController.clear();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                SearchScreen(currentIndex:state.currentIndex, searchController: searchController ,
                                ),
                          ),
                        );
                      },
                      child: const Icon(Icons.search_outlined)),
                ),
              ]),

          body:state.screens[state.currentIndex],
        );
      },
    );
  }
}
