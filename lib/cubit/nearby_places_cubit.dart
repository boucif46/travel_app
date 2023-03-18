import 'package:bloc/bloc.dart';
import 'package:travello/cubit/nearby_places_state.dart';
import 'package:travello/models/travel_place_model.dart';
import 'package:travello/services/api_services.dart';


class NearbyPlaceCubit extends Cubit<NearbyPlaceState> {
  final ApiService apiService;
  PlaceModel? places ;
  NearbyPlaceCubit( this.apiService) : super(NearbyPlacefirst());
  
  
  Future<void> getNearbyPlaces(double lat, double lng) async {
    emit(NearbyPlaceLoading());
    try {
        places = await apiService.nearbySearch(lat, lng);
      emit(NearbyPlaceLoaded());
    } catch (e) {
      emit(NearbyPlaceError());
    }
  }
}
