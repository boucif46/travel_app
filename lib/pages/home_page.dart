


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travello/cubit/travel_places_cubit.dart';
import 'package:travello/models/travel_place_model.dart';
import 'package:travello/widgets/places_container.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
  
}


   

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  
  Widget build(BuildContext context) {
     BlocProvider.of<TravelPlacesCubit>(context).getPlaces();
   
    TabController _tabController = TabController(length: 3,vsync: this);

    return Scaffold(
      body: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          
          Container(
            margin: EdgeInsets.only(top: 45,bottom: 20),
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children:  [
               const  Text("Hey! ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey
                ),),
               const  Text("boucif ",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 102, 46, 46)
                ),),
                Expanded(child: Container()),
               const CircleAvatar(
                  child: Image(image: AssetImage("images/profile.jpg")),
                  radius: 20,
                )

              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left:30,right:30),
            margin: EdgeInsets.only(bottom: 20),
            child: const Text(
              "Travel is never\na matter of money",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color:  Color.fromARGB(255, 75, 60, 60)

              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15),
            child:  Align(
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
                  Tab(text: "Places"),
                  Tab(text: "Inspiration"),
                  Tab(text: "Emotions"),
                  ]
              ),
            )
          ),
          const SizedBox(height: 8,),
          Expanded(
            
           child: TabBarView(
            controller: _tabController,
            
            children: [
               PlacesContainer(),
              Container(),
              Container()
            ]),
          )
        ],
      )
    );
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