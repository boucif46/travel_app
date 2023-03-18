import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travello/cubit/travel_places_cubit.dart';
import 'package:travello/pages/home_page.dart';
import 'package:travello/pages/main_page.dart';
import 'package:travello/services/shared_prefrence.dart';

class IntroWidget extends StatelessWidget {
  final String text ;
  final String image;
  double? textHeight ;
  bool isFinal = false ;

   IntroWidget({super.key, required this.text, required this.image,this.textHeight,required this.isFinal });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
           Positioned.fill(
            child:  Image(image: AssetImage(image),
              fit: BoxFit.cover,),
            ),
          Positioned(
            top: textHeight ?? 550,
            left: 20,
            right: 20,
            child: Text(
              text,
              style: const TextStyle(
                fontSize:30 ,
                color:Color.fromARGB(255, 253, 253, 198),
                fontWeight: FontWeight.bold,
              ),
            )
            ),

          Positioned(
            bottom: 120,
            left: 100,
            child: isFinal ? InkWell(
              enableFeedback: true,
              excludeFromSemantics: true,
              
              onTap: () 
              {
                 
                print('tapped');
                introSHow();
                BlocProvider.of<TravelPlacesCubit>(context).getPlaces();
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>  MainPage(),
                  ),
                );
                
              },
              
              child: Container(
                 height: 60,
                 width: 260,
                 padding: EdgeInsets.all(8),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:Color.fromARGB(255, 34, 155, 96).withOpacity(0.5)
                ),
                child:const Center(
                  child:  Text("Let's Go",
                  style:TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 253, 253, 198),
                  )
                  ),
                ),
              ),
            ) : Container()
            )   

        ],
      ),
    );
  }
}

 introSHow() async{
 await MySharedPreference.setBool('introShown', true);

}