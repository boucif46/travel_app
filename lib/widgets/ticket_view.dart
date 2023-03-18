import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class Ticket extends StatelessWidget {
  final int id ; 
  final String destination ;
  final int  days ; 
  final String name ;
  final String lastName;
  final String  startingTime ;
  final String  endingTime ;
  final int isConfirmed;


   Ticket({super.key, 
   required this.id, 
   required this.destination, 
   required this.days, 
   required this.name, 
   required this.lastName, 
   required this.startingTime,
   required this.endingTime,
   required this.isConfirmed});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
          width: MediaQuery.of(context).size.width*0.9,
          height: 200,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:  [
                /*
                blue container 
               */
                Container(
                  padding:const  EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFF526799),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(21),
                      topRight: Radius.circular(21)
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                        const  SizedBox(
                          width: 120,
                           child: const  Text("Destination to",style: TextStyle(color: Colors.white,
                            fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                         ),
                         const   Spacer(),
                         //circle
                           Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 2.5,color: Colors.white)
                            ),
                           ),
                           
                            Expanded(child: SizedBox(
                              height: 24,
                              child:Stack(
                                children: [
                                      LayoutBuilder(
                                      builder: (BuildContext , BoxConstraints ) { 
                                      return Flex(
                                      
                                      direction:Axis.horizontal,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:  List.generate((BoxConstraints.constrainWidth()/6).floor(), (index) =>Center(child: const  Text("-",style:TextStyle(color: Colors.white,))))
                                      
                                      );
                                    },
                                  
                                  ),
                                

                                ],
                              ),
                            )),
                           

                           //circle
                           Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 2.5,color: Colors.white)
                            ),
                           ),
                          const   Spacer(),
                          SizedBox(
                            width: 120,
                            child:   Text(name,style:const  TextStyle(color: Colors.white,
                            fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.end,),
                          ),
                        ],
                      ),
                     const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          SizedBox(
                            width: 100,
                            child: Text(destination,style: TextStyle(color: Colors.white,fontSize: 16),),
                          ),
                          Text('$days Days',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                          SizedBox(
                            width: 100,
                            child: Text(lastName,style: TextStyle(color: Colors.white,fontSize: 16,),textAlign: TextAlign.end,),
                          ),

                        ],
                      )
                    
                    ],
                  ),
                )
              ,
              /*
              top part of orange
               */
              Container(
                color:isConfirmed == 1 ?Colors.green: const  Color(0xFFF37B67),
                child: Row(
                  children:  [
                   const  SizedBox(
                      height: 20,
                      width: 10,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8)
                          )
                        )
                      ),
                    ),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: LayoutBuilder(
                        builder: (BuildContext , BoxConstraints ) { 
                    
                          return  Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children:List.generate(((BoxConstraints.constrainWidth()/15).floor()), (index) =>const  SizedBox(
                           width: 5,
                           height: 1,
                           child: DecoratedBox(
                            decoration: BoxDecoration(color:Colors.white )
                            ),
                          )),
                        );
                         },
                       
                      ),
                    )),
                   const   SizedBox(
                      height: 20,
                      width: 10,
                      child: DecoratedBox(
                        
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8)
                          )
                        )
                      ),
                    ),

                  ],
                ),
              )
              
              ,
              /*
              bottom part of orange 
               */
              Container(
                padding:const  EdgeInsets.all(16),
                 decoration:  BoxDecoration(
                    color:isConfirmed == 1 ?Colors.green: const Color(0xFFF37B67),
                     borderRadius:const BorderRadius.only(
                      bottomLeft: Radius.circular(21),
                      bottomRight: Radius.circular(21)
                    )
                  ),
                  child:Column(
                    children: [
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             const  Text('Trip start',style:
                               TextStyle(color: Colors.white,
                          fontSize: 16,fontWeight: FontWeight.bold),),
                          const  SizedBox(height: 10,),
                           Text(startingTime,style:
                             const   TextStyle(color: Colors.white,
                          fontSize: 16,fontWeight: FontWeight.normal),),
                            ],
                          ),
                            //middle column
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('ID: $id',style:
                              const TextStyle(color: Colors.white,
                          fontSize: 16,fontWeight: FontWeight.bold),),
                          const SizedBox(height: 10,),
                           Text(isConfirmed == 1 ? "confirmed":"Not confirmed",style:
                             const   TextStyle(color: Colors.white,
                          fontSize: 16,fontWeight: FontWeight.normal),),
                            ],
                          ),
                          //third column 
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Trip end ',style:
                               TextStyle(color: Colors.white,
                          fontSize: 16,fontWeight: FontWeight.bold),),
                          const SizedBox(height: 10,),
                           Text(endingTime,style:
                           const     TextStyle(color: Colors.white,
                          fontSize: 16,fontWeight: FontWeight.normal),),
                            ],
                          ),


                        ],
                      )
                    ],
                  ) ,
              )
              ],
            ),
          ),
        );
      
  }
}