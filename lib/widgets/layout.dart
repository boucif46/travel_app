import 'package:flutter/material.dart';

class Layout {

static height(double height ,BuildContext context){

  return MediaQuery.of(context).size.height ;
}

static width(double width ,BuildContext context){

  return MediaQuery.of(context).size.width ;
}




}