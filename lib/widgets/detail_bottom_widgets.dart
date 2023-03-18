import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:travello/pages/travel_form.dart';
import 'package:travello/services/shared_prefrence.dart';

class DetailBotomWidget extends StatefulWidget {
  double price;
  int id;
  String destinationName ;
  DetailBotomWidget({super.key, required this.price, required this.id,required this.destinationName});

  @override
  _DetailBotomWidgetState createState() => _DetailBotomWidgetState();
}

class _DetailBotomWidgetState extends State<DetailBotomWidget> {
  bool tapped = false;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  Future<void> _checkFavorite() async {
    bool isFavorite = await MySharedPreference.isFavorite(widget.id);
    setState(() {
      tapped = isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      shadowColor: Colors.grey,
      child: Container(
        height: 75,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white70.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$${widget.price}",
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Trip Ammount",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    tapped = !tapped;

                    if (tapped) {
                      MySharedPreference.addToFavorites(widget.id);
                      print("added");
                    } else {
                      MySharedPreference.removeFromFavorites(widget.id);
                      print("removed");
                    }
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green, width: 1),
                  ),
                  child: tapped
                      ? Icon(
                          Icons.favorite_outlined,
                          color: Colors.green,
                          size: 30,
                        )
                      : Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.green,
                          size: 30,
                        ),
                ),
              ),
              GestureDetector(
                onTap: ()async{
                 int  userId = await MySharedPreference.getUserId('userId');
                 if(userId != 0){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  TravelReservationPage(destinationId: widget.id, price: widget.price,destinationName: widget.destinationName,userId: userId,
                  )));}else{
                                  // Show an error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('please login ')));
      
                  }
                },
                child: Container(
                  height: 50,
                  width: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 255, 124, 64)),
                  child: const Center(
                      child: Text(
                    "BOOK NOW",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.00000000000001),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
