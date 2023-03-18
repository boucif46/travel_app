import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travello/cubit/account_cubit.dart';
import 'package:travello/cubit/travel_form_states.dart';
import 'package:travello/models/Travel_form_model.dart';
import 'package:travello/services/api_services.dart';
import 'package:travello/services/shared_prefrence.dart';

class TravelFormCubit extends Cubit<TravelFormStates>{
  
  
  ApiService apiService ;
  TravelFormCubit(this.apiService):super(TravelFormInitial());
  
  List<Trip>? trips ;

  Future<void> receiveForm() async {

    emit(TravelFormLoading());
    try {
      print('frm inside the cubit');
      int userId = await MySharedPreference.getUserId('userId');
       trips  = await apiService.getTripsByUserId(userId);
       print(trips);
      emit(TravelFormLoaded());
    } catch (e) {
      emit(TravelFormFailure());
    }
  }

}