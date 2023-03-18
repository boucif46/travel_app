import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travello/cubit/travel_places_cubit.dart';
import 'package:travello/cubit/travel_places_state.dart';
import 'package:travello/models/travel_place_model.dart';
import 'package:travello/pages/detail_page.dart';
import 'package:travello/widgets/detail_bottom_widgets.dart';
class PlacesContainer extends StatelessWidget {
 
   PlacesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<TravelPlacesCubit,TravelPlacesState>(builder: (context,state){
      if(state is TravelPlacesLoading){
        return const Center(child:CircularProgressIndicator(color: Color.fromARGB(255, 95, 30, 30),));
      }else if(state is TravelPlacesGetSuccess){
        PlaceModel? places = BlocProvider.of<TravelPlacesCubit>(context).placeList!;
        return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: StaggeredGridView.countBuilder(
                    itemCount: places.placesCount,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    
                    crossAxisCount: 4,
                    staggeredTileBuilder: (index) => index %2 ==0 ?const  StaggeredTile.count(2,3 ) : const StaggeredTile.count(2,2.2),
                  
                  
                  itemBuilder: (context, index) {
                    return  Material(
                      elevation: 8.0,
                      borderRadius: BorderRadius.circular(12),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:(context) => DetailPage(place:places.places[index]),));
                        },
                        child: Container(
                          
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            image:  DecorationImage(image: NetworkImage("http://127.0.0.1:8000${places.places[index].image}"),
                            fit: BoxFit.cover),
                            boxShadow: [
                                BoxShadow(
                                  color: Colors.white70.withOpacity(0.2),
                                  spreadRadius: 18,
                                  blurRadius:8,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 15,
                                left: 10,
                                child: Text(
                                  places.places[index].name,
                                  overflow:TextOverflow.ellipsis,
                                  style:const  TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                    
                                          
                                  ),
                                ))
                            ],
                          ),
                         ),
                      ),
                    );
                    
                  },
                  
                ),
               
              );
      }else if(state is TravelPlacesGetFailure){
         return const Center(child: Text("Somthing went wrong!!",style: TextStyle(color: Colors.red),),);
      }else{
        return const Center(child:CircularProgressIndicator(color: Color.fromARGB(255, 95, 30, 30),));
      }

    });
  }
}





