import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:travello/widgets/intro_container.dart';



class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageIndicatorContainer(
        length: 3,
        indicatorColor: Colors.grey,
        indicatorSelectorColor: Colors.blue,
        shape: IndicatorShape.roundRectangleShape(),
        padding: EdgeInsets.only(bottom: 50),
        child: PageView(
          children: [
            Container(
              color: Colors.red,
              child: IntroWidget(text: "The world is a book and those who do not travel read only one page.",image: "images/intro1.jpg",textHeight: 490,isFinal: false,)
            ),
            Container(
              color: Colors.blue,
              child: IntroWidget(text: "Travel broadens the mind and enriches the soul.",image: "images/intro2.jpg",textHeight: 200,isFinal: false,)
            ),
            Container(
              color: Colors.green,
              child:  IntroWidget(text: "Life is short, So make memories in every destination.",image: "images/intro3.jpg",textHeight: 470,isFinal: true,)
            ),
          ],
        ),
      ),
    );
  }
}