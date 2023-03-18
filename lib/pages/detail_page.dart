import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:travello/models/travel_place_model.dart';
import 'package:travello/widgets/detail_bottom_widgets.dart';

class DetailPage extends StatelessWidget {
 
 Place place;
   DetailPage({super.key,required this.place});

  @override
  Widget build(BuildContext context) {
    List<String> images =  [
      "images/intro1.jpg",
      "images/intro2.jpg",
      "images/intro3.jpg",
      "images/profile.jpg",
    ]  ;
    
    return Scaffold(
      body: Stack(
        children: [
          //image positioned
          Positioned(
            top:0,
            left: 0,
            right: 0,
            child: Container(
              height: 400,
              width: double.maxFinite,
              child:  Image(image: NetworkImage("http://127.0.0.1:8000${place.image}"),
              fit: BoxFit.fill,),
              
            ) 
          ),
         //back arrow and profile picture
          Positioned(
            top: 60,
            right: 20,
            left: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child:const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Center(child: Icon(Icons.arrow_back_ios,),),  
                  ),
                ),
                 const CircleAvatar(
                  foregroundImage: AssetImage("images/profile.jpg"), 
                  radius: 20,
                )
              ],
            )
          ),
         //main container
          Positioned(
            bottom: 0 ,
            left: 0,
            right: 0,
            child: Container(
              height:420,
              width: double.maxFinite,
              padding:const EdgeInsets.only(top: 20,right: 20,left: 20),
              decoration:const  BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40)),
                  color: Colors.white
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              
                    //name and stars 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
              
                         Text(place.name,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(221, 14, 13, 13)
                        ),),
                        Container(
                          height: 30,
                          width: 65,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.green
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                              const   Icon(Icons.star,color: Colors.white,size:15 ,),
                                Text("${place.stars}/5",style:const  TextStyle(color: Colors.white),),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                   const SizedBox(height: 15,),
                    //icon camp and days
                    Row(
                      children:  [
                       const  Icon(Icons.cabin,color:   Color.fromARGB(255, 255, 124, 64),),
                       const  SizedBox(width: 5,),
                        Text("${place.travelTime} Days",style: const TextStyle(color: Color.fromARGB(255, 49, 44, 44),fontSize: 16),)
                      ],
                    ),
                   const SizedBox(height: 15,),
                    //Galerie name
                   Row(
                    children: const[
                       Text("Galeries",style: TextStyle(fontSize:25,color: Colors.black,fontWeight: FontWeight.bold),),
                    ],
                   ),
                   const SizedBox(height: 5,),
                   //Galerie images
                   Container(
              
                    height: 200,
                    width: double.maxFinite,
                    padding:const  EdgeInsets.symmetric(horizontal: 0,vertical: 5),
                    
                    child: ListView.builder(
              
                      scrollDirection: Axis.horizontal,
                      itemCount: place.galleries.length,
                      itemBuilder: (context,index){
                        return Container(
                          height: 180,
                          width: 150,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(image: NetworkImage("http://127.0.0.1:8000${place.galleries[index].imageUrl}"),fit: BoxFit.fill)
                          ),
                          
                        );
                      }),
              
                   ),
                  const SizedBox(height: 5,),
                   //DESCRIPTION
                  const Text("Description",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black87),),
                  Container(
                    padding:const EdgeInsets.only(left: 10,right: 3),
                    child:  Text(place.description,
                  style:const  TextStyle(fontSize: 16,
                                   color: Colors.black54,
                                   height: 1.5,
                                  
                                    ),)
                  )
                
                  ]
                ),
              ),
            )),
        ],
      ),
      bottomNavigationBar:  DetailBotomWidget(price: place.price.toDouble(),id: place.id,destinationName: place.name,),
    );
  }
}