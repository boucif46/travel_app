import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travello/cubit/favourite_places_cubit.dart';
import 'package:travello/cubit/favourite_places_states.dart';
import 'package:travello/cubit/travel_places_cubit.dart';
import 'package:travello/models/travel_place_model.dart';
import 'package:travello/pages/detail_page.dart';
import 'package:travello/services/shared_prefrence.dart';

class FavouritePlaces extends StatelessWidget {
  const FavouritePlaces({super.key});

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<FavouritePlaceCubit>(context).getFavouritePlaces();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text("Favourite Places",style: TextStyle(
            fontSize: 24
          ),
          
          ),
        ),
        automaticallyImplyLeading: false,
        
      ),
      body: BlocBuilder<FavouritePlaceCubit,FavouritePlacesState>(
        
        
        builder: (context,state){
          if(state is FavouritePlacesLoading){
            return const Center(child: CircularProgressIndicator(),);

          } else if(state is FavouritePlacesLoaded){
            List<Place> places = BlocProvider.of<TravelPlacesCubit>(context).placeList!.places ;
             List<int> placesIds = BlocProvider.of<FavouritePlaceCubit>(context).ids!;
             List<Place> favouritePlaces ;
              List<Place> getFavoritePlaces(List<Place> places, List<int> placesIds) {
                return places.where((place) => placesIds.contains(place.id)).toList();
              }
            
            favouritePlaces = getFavoritePlaces(places, placesIds);
                
            return ListView.builder(
    
              itemCount: favouritePlaces.length,
              itemBuilder: (context, index) {
                return  SingleChildScrollView(
                  child: Container(
                     margin: EdgeInsets.all(10),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color:Colors.blue 
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                        
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                             // Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailPage(place: places.places[index])));
                            },
                            child: Container(
                              height: 120,
                              width: 170,
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image:  DecorationImage(
                                      image: NetworkImage(
                                          "http://127.0.0.1:8000"+favouritePlaces[index].image),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          SizedBox(
                            // padding: EdgeInsets.only(right: 20),
                      
                            height: 120,
                            width: 150,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                  Text(
                                    favouritePlaces[index].name,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 36, 33, 33),
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                   favouritePlaces[index].description,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 36, 33, 33),
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap:(){
                                          MySharedPreference.removeFromFavorites(favouritePlaces[index].id);
                                          BlocProvider.of<FavouritePlaceCubit>(context).getFavouritePlaces();
                                        },
                                        child: Icon(Icons.delete,color: Colors.red,size:28 ,))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                  ),
                );
              },
            );
          }else if(state is FavouritePlacesFailure){
            return Center(
              child: Text("Something wont wrong !")
              
            );
          }else {
            return Center(child: Text("there is nothig in the favourite List"),);
          }
        }
        
        ),
    );
  }
}