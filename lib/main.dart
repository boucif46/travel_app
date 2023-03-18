import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travello/cubit/account_cubit.dart';
import 'package:travello/cubit/favourite_places_cubit.dart';
import 'package:travello/cubit/nearby_places_cubit.dart';
import 'package:travello/cubit/travel_form_cubit.dart';
import 'package:travello/cubit/travel_places_cubit.dart';
import 'package:travello/pages/intropages.dart';
import 'package:travello/pages/main_page.dart';
import 'package:travello/pages/register.dart';
import 'package:travello/pages/travel_form.dart';
import 'package:travello/services/api_services.dart';

import 'package:travello/services/shared_prefrence.dart';
import 'package:travello/widgets/curve_paint.dart';
import 'package:travello/widgets/ticket_view.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) {
        return TravelPlacesCubit(ApiService());
      },
    ),
    BlocProvider(
      create: (context) {
        return NearbyPlaceCubit(ApiService(),);
      },
    ),
    BlocProvider(
      create: (context) {
        return FavouritePlaceCubit(MySharedPreference());
      },
    ),
    BlocProvider(
      create: (context) {
        return AccountCubit(ApiService());
      },
    ),
    BlocProvider(
      create: (context) {
        return TravelFormCubit(ApiService());
      },
    ),

  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _introShown = false;

  @override
  void initState() {
    super.initState();
    seenBefore().then((value) {
      setState(() {
        _introShown = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _introShown != null
          ? (_introShown ? MainPage() : IntroPage())
          : Container(),
    );
  }

  Future<bool> seenBefore() async {
    bool introShown = await MySharedPreference.getBool('introShown');
    
    return introShown;
  }
}
