import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constance.dart';
import '../screens/movie_detail_screen.dart';

class SeeMoreComponent extends StatelessWidget {
  final Movie movie;
  final bool d=false ;
  const SeeMoreComponent({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0,right: 10,top:10),
        child: ClipRRect(
        borderRadius:
        const BorderRadius.all(Radius.circular(8.0)),
        child: Container(
          color:d? Colors.white24:Colors.black26,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MovieDetailScreen(
                        id: movie.id,
                      ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius:
              const BorderRadius.all(Radius.circular(8.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: CachedNetworkImage(
                      width: 115,
                      height: 165,
                      fit: BoxFit.fill,
                      imageUrl: ApiConstance.imageUrl("${movie.backdropPath}"),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[850]!,
                        highlightColor: Colors.grey[800]!,
                        child: Container(
                          width: 115,
                          height: 165,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),
                  ),
                ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11.0,right: 8),
                        child: SizedBox(
                          height: 160,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:5),
                                child: Text(
                                  movie.title,style: const TextStyle( fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),overflow:TextOverflow.ellipsis ,maxLines:2 ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4.0),
                                    child: Container(color: Colors.red,child: Padding(
                                      padding: const EdgeInsets.only(left: 9.0,right:9 ,top:3 ,bottom:3 ),
                                      child: Text(movie.releaseDate.substring(0,4),style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                    ),),
                                  ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15.0),
                                        child: Row(
                                            children: [
                                          const Icon(Icons.star,color: Colors.yellow,size: 20),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 3.0),
                                            child: Text("${movie.voteAverage}",style:const TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                                          ),
                                        ]),
                                      ),

                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:10.0),
                                child: Text('overview:  ${movie.overview}',
                                  overflow:TextOverflow.ellipsis ,maxLines:4 ,style: const TextStyle(fontSize:12 , fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
                              )
                            ],
                          ),
                        ),
                      ),
                    )

              ]),
            ),
          ),
        ),
    ),
      );
  }
}
