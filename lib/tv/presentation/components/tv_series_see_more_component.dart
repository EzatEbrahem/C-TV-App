import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/tv/domain/entities/tv_series.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/network/api_constance.dart';
import '../screens/tv_series_detail_screen.dart';


class TvSeriesSeeMoreComponent extends StatelessWidget {
  final TvSeries tvSeries;
  const TvSeriesSeeMoreComponent({Key? key, required this.tvSeries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final height=size.height;
    final width=size.width;
    return Padding(
        padding: const EdgeInsets.only(left: 10.0,right: 10,top:10),
        child: ClipRRect(
        borderRadius:
        const BorderRadius.all(Radius.circular(8.0)),
        child: Container(
          color:Colors.black26,
          child: InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      TvSeriesDetailScreen(
                        id: tvSeries.id,
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
                      width: width*0.35,
                      height: height*0.22,
                      fit: BoxFit.fill,
                      imageUrl: ApiConstance.imageUrl(tvSeries.backdropPath),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[850]!,
                        highlightColor: Colors.grey[800]!,
                        child: Container(
                          width: width*0.35,
                          height: height*0.22,
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  tvSeries.name,style: const TextStyle( fontSize: 19,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),overflow:TextOverflow.ellipsis ,maxLines:2 ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4.0),
                                    child: Container(color: Colors.red,child: Padding(
                                      padding: const EdgeInsets.only(left: 9.0,right:9 ,top:3 ,bottom:3 ),
                                      child: Text(tvSeries.firstAirDate.substring(0,4),style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                    ),),
                                  ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15.0),
                                        child: Row(
                                            children: [
                                          const Icon(Icons.star,color: Colors.yellow,size: 21),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 3.0),
                                            child: Text("${tvSeries.voteAverage}".substring(0,3),style:const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                          ),
                                        ]),
                                      ),

                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:20.0),
                                child: Text('overview:  ${tvSeries.overview}',
                                  overflow:TextOverflow.ellipsis ,maxLines:3 ,style: const TextStyle(fontSize:13 , fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
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
