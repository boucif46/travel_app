import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travello/cubit/favourite_places_cubit.dart';
import 'package:travello/cubit/favourite_places_states.dart';
import 'package:travello/cubit/travel_form_cubit.dart';
import 'package:travello/cubit/travel_form_states.dart';
import 'package:travello/cubit/travel_places_cubit.dart';
import 'package:travello/models/Travel_form_model.dart';
import 'package:travello/models/travel_place_model.dart';
import 'package:travello/pages/detail_page.dart';
import 'package:travello/pages/login.dart';
import 'package:travello/pages/register.dart';
import 'package:travello/services/shared_prefrence.dart';
import 'package:travello/widgets/ticket_view.dart';

class UserTripsPage extends StatelessWidget {
  const UserTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
     
     BlocProvider.of<TravelFormCubit>(context).receiveForm() ;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:const  Center(
          child: Text("Trips Tickets",style: TextStyle(
            fontSize: 24
          ),
          
          ),
        ),
        automaticallyImplyLeading: false,
        
      ),
      body: BlocBuilder<TravelFormCubit,TravelFormStates>(

        
        builder: (context,state){
          return FutureBuilder<int>(
            future: getUserId(),
            builder:(context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child:  CircularProgressIndicator()
            );

          }else if(snapshot.hasData && snapshot.data == 0){
            return  Center(
              child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       const Text(
                'Please register or login',
                style: TextStyle(fontSize: 24.0),
              ),
                       const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                child: Text('Login'),
              ),
                       const  SizedBox(height: 16.0),
              OutlinedButton(
                onPressed: () {
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>RegisterScreen()));
                },
                child: Text('Register'),
              ),
                      ],
                    ),
            );
          }else  if(state is TravelFormLoading){
            return const Center(child: CircularProgressIndicator(),);

          } else if(state is TravelFormLoaded){
            List<Trip>? places = BlocProvider.of<TravelFormCubit>(context).trips ;

            return  Container(
                width: double.maxFinite,
                height: double.maxFinite,
                child: ListView.builder(
                  
                  itemCount: places!.length,
                  itemBuilder: (context, index) {
                    return Container(
                        padding:const  EdgeInsets.all(16),
                        child: Ticket(id: places[index].id,
                        destination:places[index].destinationName ,
                        days: 6,
                        name: places[index].name,
                        lastName: places[index].lastName,
                        startingTime: places[index].startingTrip,
                        endingTime: places[index].endingTrip,
                        isConfirmed: places[index].confirmed,
                        ),
                      ) ;
                  
                  },
                ),
             
            );
          }else if(state is FavouritePlacesFailure){
            return Center(
              child: Text("Something wont wrong !")
              
            );
          }else {
            return Center(child: Text("there is nothig in your trips List"),);
          }

            } 
          );
        }
        
        ),
    );
  }

 Future<int> getUserId() async {
  int userId = await MySharedPreference.getUserId('userId');

  return userId ;
 }
}

/*

{

          
         
        } */