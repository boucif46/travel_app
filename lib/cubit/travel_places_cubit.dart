import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travello/cubit/travel_places_state.dart';
import 'package:travello/models/travel_place_model.dart';
import 'package:travello/services/api_services.dart';

class TravelPlacesCubit extends Cubit<TravelPlacesState>
{

  ApiService apiService  ;
  PlaceModel? placeList ;
  TravelPlacesCubit( this.apiService):super(TravelPlacesInitial());

  void getPlaces() async{
   emit(TravelPlacesLoading());
   try{
    placeList = await apiService.getPlaces();
    emit(TravelPlacesGetSuccess());
   }on Exception catch (e){
    print(e);
    emit(TravelPlacesGetFailure());
   }
   
  
  }

}