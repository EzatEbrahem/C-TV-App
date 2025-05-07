import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/movies/domain/entities/reviews.dart';
import 'package:movies_app/movies/presentation/controller/movie_detail_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constance.dart';
import '../../../core/utils/enums.dart';
import '../controller/movie_detail_state.dart';

class ReviewComponent extends StatelessWidget {
  const ReviewComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc,MovieDetailState>(
      buildWhen:(previous, current) => previous.reviewsMovieState!=current.reviewsMovieState ,
      builder: (context,state){
        switch(state.reviewsMovieState){
          case RequestState.loading:
            return const Center(
              child: SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          case RequestState.loaded:
                if(state.reviewsMovie.isNotEmpty){
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder:(context, index) => reviewItem(context,state.reviewsMovie[index]!),
                      separatorBuilder:(context, index) => const SizedBox(height: 5,),
                      itemCount: state.reviewsMovie.length);
                }else{
                  return const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                    child: Center(child:Image(image: AssetImage('assets/review2.jpg'),width:230 ,height:230 , ),)
                  );
                }

          case RequestState.error:
            return SizedBox(
              height: 170.0,
              child: Center(
                child: Text(state.reviewsMovieMessage),
              ),
            );
        }
      }

    );
  }


}
Widget reviewItem(context, ReviewsMovie reviewsMovie)=>Card(
  margin:const EdgeInsets.symmetric(horizontal: 12,vertical: 5) ,
  elevation: 10,shadowColor: Colors.white,
  clipBehavior: Clip.antiAliasWithSaveLayer,
  child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              child: CachedNetworkImage(
                width: 45,
                height: 45,
                fit: BoxFit.fill,
                imageUrl: ApiConstance.imageUrl("${reviewsMovie.authorDetails?.avatarPath}"),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[850]!,
                  highlightColor: Colors.grey[800]!,
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) =>
                const Icon(Icons.person,size:30 ),
              ),
            ),
            const SizedBox(
              width:13 ,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(reviewsMovie.author,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            height: 1.3
                        ),),
                      const SizedBox(
                        width: 5,),
                      const Icon(Icons.check_circle,
                        color: Colors.blue,
                        size: 16,)
                    ],
                  ),
                  Text(reviewsMovie.createdAt.substring(0,10),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                        height: 1.3
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20.0,
                ),
                const SizedBox(width: 4.0),
                Text(
                      "${reviewsMovie.authorDetails?.rating??"No Rating"}",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Container(
            width: double.infinity,
            height: 1.1,
            color: Colors.grey[400],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 5),
          child: Text(
            reviewsMovie.content,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
                height: 1.4
            ),),
        ),
      ],
    ),
  ),
);


