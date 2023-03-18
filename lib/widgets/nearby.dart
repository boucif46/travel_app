import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travello/cubit/nearby_places_cubit.dart';
import 'package:travello/cubit/nearby_places_state.dart';
import 'package:travello/models/travel_place_model.dart';
import 'package:travello/pages/detail_page.dart';
import 'package:travello/pages/login.dart';
import 'package:travello/pages/register.dart';
import 'package:travello/services/shared_prefrence.dart';

class Nearby extends StatelessWidget {
  const Nearby({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<NearbyPlaceCubit, NearbyPlaceState>(


        builder: (context, state)  {
       return FutureBuilder<String>(
        
        future: getToken(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child:  CircularProgressIndicator()
            );

          }else if(snapshot.hasData && snapshot.data == 'nothing'){
            return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const Text(
              'To see nearby places',
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
        );
          }else{
            if (state is NearbyPlaceLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Color.fromARGB(255, 95, 30, 30),
          ));
        } else if (state is NearbyPlaceLoaded) {
          PlaceModel? places =
              BlocProvider.of<NearbyPlaceCubit>(context).places!;
          return ListView.builder(
              itemCount: places.placesCount,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailPage(place: places.places[index])));
                      },
                      child: Container(
                        height: 120,
                        width: 170,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "http://127.0.0.1:8000${places.places[index].image}"),
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
                          children: [
                            Text(
                              places.places[index].name,
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
                              places.places[index].description,
                              maxLines: 3,
                              style: const TextStyle(
                                
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 36, 33, 33),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              });
        } else if (state is NearbyPlaceError) {
          return const Center(
            child: Text(
              "Somthing went wrong!!",
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(
              child:Text(
              "Choose place in the map",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),));
        }
      }

      });
          }
    ); 
   
  }

  Future<String> getToken() async {
    String token = await MySharedPreference.getToken('token');
    
    return token ;
  }
}



/*
ListView.builder(
        itemCount:5 ,
        itemBuilder: (context,index){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 120,
                  width: 170,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(15),
                    image: const DecorationImage(image: AssetImage("images/intro3.jpg"),fit: BoxFit.cover)
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
                        children: const [
                           Text(
                            "Rio de Janeiro ",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 36, 33, 33),
                              overflow: TextOverflow.ellipsis
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "this is a short description for this  travel",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 36, 33, 33),
                             // overflow: TextOverflow.ellipsis
                            ),
                          ),
                        ],
                      ),
                  ),
                ),
                
              ],
            );
          
        }
        );
*/



//column of two buttom
/*
 */