

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:travello/cubit/nearby_places_cubit.dart';
import 'package:travello/cubit/nearby_places_state.dart';
import 'package:travello/models/travel_place_model.dart';
import 'package:travello/pages/detail_page.dart';

import 'package:travello/widgets/nearby.dart';



class Search extends StatefulWidget{

   const Search({super.key});
  State<Search> createState() => _SearchState();



}

class _SearchState extends State<Search> with TickerProviderStateMixin{

 


  LatLng latLng = LatLng(29.373286, 3.022080);
  
  // final TextEditingController _textEditingController = TextEditingController();
  // PlaceModel? place  ;
  // Future<PlaceModel> _onSearchPressed() async{
  //   final String searchText = _textEditingController.text;
  //   final List<String> tags = searchText.split(' ');
  //   // Call the search method with the tags
  //   print("the tags is "+tags.toString());
  
  //  var places =  await  ApiService().searchPlaces(tags);
  //   print(places);
  //   place = places ;
  //   return places ;
  // }
   late MapController _mapController;
  late LatLng _selectedPosition;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _selectedPosition = LatLng(0, 0); // initialize to (0, 0) coordinates
  }


  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3,vsync: this);
    //BlocProvider.of<NearbyPlaceCubit>(context).getNearbyPlaces(lat, lng);
      
    return Scaffold(
      body: Stack(
        children: [
          //map
          BlocBuilder<NearbyPlaceCubit, NearbyPlaceState>(

            builder: (context,state){
              if(state is NearbyPlaceLoaded){
                PlaceModel? places =
                              BlocProvider.of<NearbyPlaceCubit>(context).places!;
                 return Positioned(
                top: 0,
                left: 0,
                right: 0,
                child:Container(
                  height: 400,
                  width: double.maxFinite,
                  child:FlutterMap(
                    options: MapOptions(

                      enableScrollWheel: false,
                        center:  latLng,
                        zoom: 4.5,
                        onTap: _handleTap,
                    ),
                    nonRotatedChildren: [
                        AttributionWidget.defaultWidget(
                            source: 'OpenStreetMap contributors',
                            onSourceTapped: null,
                        ),
                    ],
                    children: [
                        TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                            markers: [
                              
                              Marker(
                                width: 80.0,
                                height: 80.0,
                                point: _selectedPosition, // display the marker at selected position
                                builder: (ctx) => const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 50.0,
                                ),
                              ),
                              
                              ...List.generate(places.placesCount, (index) {
                              return Marker(
                                point: LatLng(places.places[index].latitude , 
                                              places.places[index].longitude 
                                                  ), 
                                
                                builder: (context)=>
                                GestureDetector(
                                  onTap: () {
                                     Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailPage(place: places.places[index])));
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.white,
                                
                                      ),
                                      image: DecorationImage(image: NetworkImage('http://127.0.0.1:8000'+places.places[index].image),fit: BoxFit.cover)
                                    ),
                                  ),
                                ));
                            })]
                      ),
                    ],
                  )   ,


                )
               ) ;

              }else{
               return Positioned(
                top: 0,
                left: 0,
                right: 0,
                child:Container(
                  height: 400,
                  width: double.maxFinite,
                  child:FlutterMap(
                    options: MapOptions(

                      enableScrollWheel: false,
                        center:  latLng,
                        zoom: 5,
                        onTap: _handleTap,
                    ),
                    nonRotatedChildren: [
                        AttributionWidget.defaultWidget(
                            source: 'OpenStreetMap contributors',
                            onSourceTapped: null,
                        ),
                    ],
                    children: [
                        TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                        ),
                        
                    ],
                  )   ,


                )
               ) ;
              }
            },
          ),
          
          //main container
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 430,
              width: double.maxFinite,
              
              padding:const  EdgeInsets.only(top: 10,right: 20 ,left: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),
                color: Colors.white
                ),
              child:Column(
                children: [
                 
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      labelPadding: const EdgeInsets.only(left: 20,right: 20),
                      controller: _tabController,
                      labelColor:Colors.black ,
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Color.fromARGB(255, 102, 46, 46),
                      indicator:CircleTabIndicator(color: Color.fromARGB(255, 102, 46, 46),radius: 4),
                      tabs: const [
                        Tab(text: "Nearby"),
                        Tab(text: "Search"),
                        Tab(text: "Most Popular"),
                        ]
                    ),
                  ),

                  Expanded(
            
                  child: TabBarView(
                    controller: _tabController,
                    
                    children: [

                      Nearby(),
                      //SearchPage(),
                      Container(),
                      Container()
                    ]),
                  )
                ],
              ) ,
            ))
        ],
      ),
    );   
  }


  void _handleTap(dynamic tapPosition,LatLng position) {
    setState(() {
      _selectedPosition = position; 
      BlocProvider.of<NearbyPlaceCubit>(context).getNearbyPlaces(position.latitude, position.longitude);
    });
  }
}


class CircleTabIndicator extends Decoration{
  final Color color;
  double radius ;
  CircleTabIndicator({required this.color,required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return _CirclePainter(color:color,radius:radius);
  }
 
}
 class _CirclePainter extends BoxPainter {
  final Color color;
  double radius ;
  _CirclePainter({required this.color,required this.radius});
  @override
  void paint(Canvas canvas,
   Offset offset,
    ImageConfiguration configuration) {
      Paint _paint = Paint();
      _paint.color = color;
      _paint.isAntiAlias =true;
      final Offset circleOffset = Offset(configuration.size!.width/2 -radius/2,configuration.size!.height -radius);
    canvas.drawCircle(offset+circleOffset, radius, _paint);
  }
    




}





/* Container(
                    
                    padding:const  EdgeInsets.symmetric(horizontal: 10),
                    height: 80,
                    width: 350,
                    child: Card(
                        margin:const  EdgeInsets.symmetric( vertical: 10),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child:  TextField(
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: GestureDetector(
                                onTap: (){
                                  _onSearchPressed();
                                },
                                child:const Icon(Icons.search,color: Colors.green,)),
                              hintText: 'Search',
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            ),
                          ),
                        ),
                  ),
                  ), */