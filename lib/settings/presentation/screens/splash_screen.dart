

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/settings/presentation/controller/app_setting_bloc.dart';
import 'package:movies_app/settings/presentation/screens/search_screen.dart';

final TextEditingController searchController = TextEditingController();
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  bottom: 30,
                  width: 55,
                  height: 55,
                  left: 167,

                  child: FloatingActionButton(
                      heroTag: "theme",
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(27) ),
                      onPressed:(){BlocProvider.of<AppSettingBloc>(context).add(const ChangeModeEvent());},
                      child: const Icon(Icons.light_mode_rounded)),
                ),
                Positioned(
                  top: 250,
                  width: 44,
                  height: 44,
                  left: 2,
                  child: FloatingActionButton(
                      heroTag: "search",
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(27) ),
                      onPressed:(){
                        if(state.currentIndex==0){
                          BlocProvider.of<AppSettingBloc>(context)
                              .add(MovieSearchEvent(query: ''));
                        }else{
                          BlocProvider.of<AppSettingBloc>(context)
                              .add(TvSearchEvent(query: ''));
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
