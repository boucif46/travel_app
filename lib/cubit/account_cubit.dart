import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travello/cubit/account_states.dart';
import 'package:travello/cubit/travel_form_cubit.dart';
import 'package:travello/models/user_model.dart';
import 'package:travello/services/api_services.dart';

class AccountCubit extends Cubit<AccountStates>{
  
  ApiService apiService ;
  User? user ;
  bool isLoded = false;
  AccountCubit(this.apiService):super(AccountInitial());

  Future<void> getUserAccount(String name, String email, String password, String passwordConfirmation) async {

    try {
      user = await apiService.register(name, email, password, passwordConfirmation) ;
      isLoded = true ;
      emit(AccountLoaded());
       
    } catch (e) {
        emit(AccountFailure()) ;
    }
  }

  Future<void> getUserAccountFromLogin(String email, String password) async {

    try {
      user = await apiService.login(email, password,) ;
      isLoded = true ;
      emit(AccountLoaded());
      
    } catch (e) {
        emit(AccountFailure()) ;
    }
  }


}