import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/settings/presentation/components/Search_component.dart';
import 'package:movies_app/settings/presentation/controller/app_setting_bloc.dart';

import '../../../core/utils/enums.dart';
class SearchScreen extends StatelessWidget {
  final int currentIndex;
  final TextEditingController searchController;
   SearchScreen({super.key, required this.currentIndex, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search",)),
      body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  boxShadow: [
                  BoxShadow(color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 35,
                    offset: Offset(0, 25),),
                  ],
                ),
                  child: TextField(
                    style: Theme.of(context).textTheme.titleMedium,
                    controller: searchController,
                    decoration:  InputDecoration(
                      suffixIcon: IconButton(icon: Icon(Icons.cancel_outlined),
                        onPressed: () {
                        if (searchController.text.isNotEmpty) {
                        searchController.clear();
                        if(currentIndex==0){ BlocProvider.of<AppSettingBloc>(context)
                            .add(MovieSearchEvent(query: ''));
                        }else{BlocProvider.of<AppSettingBloc>(context)
                            .add(TvSearchEvent(query: ''));

                        }

                      }
                        },),
                      filled: true,
                      hintText: "Search .....",

                    ),
                    onChanged: (query) {
                          if (currentIndex == 0) {
                            if(query.isEmpty){  searchController.clear();
                            }
                            BlocProvider.of<AppSettingBloc>(context)
                                .add(MovieSearchEvent(query: query));
                          } else {
                            if(query.isEmpty){  searchController.clear();
                            }
                            BlocProvider.of<AppSettingBloc>(context)
                                .add(TvSearchEvent(query: query));
                          }
                                },
                  ),
                ),
              const Expanded(
                child: CustomScrollView(
                    slivers: [
                      SliverPadding(padding: EdgeInsets.all(0),
                    sliver: SearchComponent())]),
              ),
            ],
          ),
    );
  }

}
