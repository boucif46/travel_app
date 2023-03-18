

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travello/cubit/account_states.dart';
import 'package:travello/cubit/nearby_places_cubit.dart';
import 'package:travello/cubit/nearby_places_state.dart';
import 'package:travello/models/Travel_form_model.dart';
import 'package:travello/models/travel_place_model.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:travello/models/user_model.dart';
import 'package:travello/services/shared_prefrence.dart';

import '../cubit/account_cubit.dart';

class ApiService {

  
  static const String apiUrl = 'http://127.0.0.1:8000/api/travelplaces/get';

  Future<PlaceModel> getPlaces() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json);
      return PlaceModel.fromJson(json);
    } else {
      print("nothig happen");
      throw Exception('Failed to load places');
    }
  }

  // Future<PlaceModel> searchPlaces(List<String> tags) async {

  //   final Uri url = Uri.http('127.0.0.1:8000', '/api/travelplaces/search', {'tags': tags.join(',')});

  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final json = jsonDecode(response.body);
  //     print(json);
  //     return PlaceModel.fromJson(json);
  //   } else {
  //     print("nothig happen");
  //     throw Exception('Failed to load places');

  //   }
  // }
  Future<PlaceModel> searchPlaces(List<String> tags) async {
    final baseUrl = 'http://127.0.0.1:8000/api/travelplaces/search';
    final tagsParam = tags.join(',');
    final url = '$baseUrl?tags=$tagsParam';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json);
      return PlaceModel.fromJson(json);
    } else {
      print("nothing happened");
      throw Exception('Failed to load places');
    }
  }

  Future<PlaceModel> nearbySearch(double latitude, double longitude) async {
    const baseUrl = 'http://127.0.0.1:8000/api/travelplaces/nearby';
    
    final url = '$baseUrl?lat=$latitude&lng=$longitude';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      
      return PlaceModel.fromJson(json);
    } else {
      print("nothing happened");
      throw Exception('Failed to load places');
    }
  }






  late User _user  ; 
  User get user{  return _user ;}
  var userId = 0 ;
  
  bool _isLoaded = false;
  bool get isLoaded{  return _isLoaded ;}
  
  Future<User> register(String name, String email, String password, String passwordConfirmation) async {
         const String apiUrl = 'http://127.0.0.1:8000/api/auth';
   
      http.Response response = await http.post(
      Uri.parse('$apiUrl/register'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
      
    );
  

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      _isLoaded = true ;
      _user =  User.fromJson(json);
      userId = _user.id;

      print("user Id is "+userId.toString());
      MySharedPreference.setUserId('userId',userId);
     print('from inside');
     print(isLoaded);
     await MySharedPreference.updateToken('token', _user.token);
     
      
      
    }else{
     
      throw Exception('failed to register');
    }
    return user ;
  }
 
  Future<User> login(String email, String password) async {
         const String apiUrl = 'http://127.0.0.1:8000/api/auth';
   
      http.Response response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'password': password,
      }),
      
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      _isLoaded = true ;
      _user =  User.fromJson(json);
      userId = _user.id;
      MySharedPreference.setUserId('userId',userId);
     print('from inside');
     print(isLoaded);
     await MySharedPreference.updateToken('token', _user.token);
    
    }else{
     
      throw Exception('failed to login');
    }
    return user ;
  }

  Future<void> logout(BuildContext context) async {
    // Get the user's access token from local storage
    
    final token = await MySharedPreference.getToken('token');

    // Send a request to the server to logout
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/auth/logout'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      // Remove the access token from local storage
      
      await MySharedPreference.removeToken('token');
      print("logout");
      // Navigate to the login page or show a message indicating successful logout
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('logout successfully '))
      
      );
      BlocProvider.of<AccountCubit>(context).emit(AccountInitial());
      BlocProvider.of<NearbyPlaceCubit>(context).emit(NearbyPlaceInitial());
      Navigator.of(context).pop();
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to log out. Please try again.')),
      );
      Navigator.of(context).pop();
    }
  }

  bool sendsuccess = false;
 Future<bool> sendForm(
  int destinationId ,
  int userId,
  String destinationName,
  String name,
  String lastName,
  DateTime startingTrip,
  DateTime endingTrip,
  int adultNumber,
  int childrenNumber,
  BuildContext context
 ) async {
            Map<String, dynamic> data = {
            'destination_id': destinationId,
            'user_id': userId,
            'destination_name': destinationName,
            'name': name,
            'last_name':lastName,
            'starting_trip': DateFormat('yyyy-MM-dd').format(startingTrip),
            'ending_trip': DateFormat('yyyy-MM-dd').format(endingTrip),
            'adult_number': adultNumber,
            'children_number': childrenNumber,
            'confirmed': 0
          };
          var token = await MySharedPreference.getToken('token');
          var url = Uri.parse('http://127.0.0.1:8000/api/usersTrips/store');
          var headers = {'Content-Type': 'application/json',
                         'authorization':'Bearer $token'};
          var body = jsonEncode(data);
          print(body);
          var response = await http.post(url, headers: headers, body: body);

          if (response.statusCode == 200) {
              sendsuccess = true;
             print("response : "+response.body);
            print('Trip created successfully');
            ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('book went successfully ')));
          } else {
            print('Failed to create trip. Error code: ${response.body}');
            ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('not syccesfull ')));


          }
          return sendsuccess ;
          

  }


 List<Trip> trips =[] ;
Future<List<Trip>> getTripsByUserId(int userID) async {

  
  print("hellllllllllllllllooooooooo  :: "+userId.toString());
  final url = Uri.parse('http://127.0.0.1:8000/api/usersTrips/get');
  final headers = {'Content-Type': 'application/json'};
  final body = json.encode({'id': userID});
   print('inside the get trips by user Id ');
  final response = await http.post(url, headers: headers, body: body);
  print(response.body);
  final Json = response.body ;
  if (response.statusCode == 200) {
    print('inside the 200 condition');
   final jsonList = json.decode(response.body) as List;

   try{
   print('json List'+jsonList.toString());
     trips = jsonList.map((e) => Trip.fromJson(e)).toList();
     print("bla bla");
     print(trips.length);
   } catch(e){
    print("enable to convert" +e.toString());
   }
    return trips;
 
  } else {
    throw Exception('Failed to get trips');
  }
}


}


