import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travello/cubit/favourite_places_states.dart';
import 'package:travello/services/shared_prefrence.dart';

class FavouritePlaceCubit extends Cubit<FavouritePlacesState>{
  final MySharedPreference mySharedPreference ;

  List<int>? ids ;
  FavouritePlaceCubit(this.mySharedPreference):super(FavouritePlacesInitiale());


    Future<void> getFavouritePlaces() async {

      emit(FavouritePlacesLoading());
      try {
        ids = await MySharedPreference.getFavorites();
        if(ids!.isEmpty){
          emit(FavouritePlacesInitiale());
        }else{
          emit(FavouritePlacesLoaded());
        }
      } catch (e) {
        emit(FavouritePlacesLoaded());
      }
    }
}