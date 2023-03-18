import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travello/cubit/account_cubit.dart';
import 'package:travello/cubit/account_states.dart';
import 'package:travello/cubit/nearby_places_cubit.dart';
import 'package:travello/cubit/nearby_places_state.dart';
import 'package:travello/models/user_model.dart';
import 'package:travello/pages/login.dart';
import 'package:travello/pages/register.dart';
import 'package:travello/services/api_services.dart';
import 'package:travello/services/shared_prefrence.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height:double.maxFinite,
        child: Stack(
          children: [
            // Purple gradient
            Container(
              decoration:const  BoxDecoration(
                color: Colors.white,
              ),
            ),
            // Curved top
            CustomPaint(
              size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.5,
              ),
              painter: _CustomBackgroundPainter(),
            ),
            // Circle avatar
            Positioned(
              top: MediaQuery.of(context).size.height * 0.2-30,
              left: MediaQuery.of(context).size.width / 2 - 60,
              child: const Material(
                elevation: 8.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 55,
                  child: Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 75, 161, 231),
                    size: 55,
                  ),
                ),
              ),
            ),

            

             Positioned(
              top:100,
              right: 0,
              bottom: 0,
              left: 0,
               child:  Center(

                
                 child: BlocBuilder<AccountCubit,AccountStates>(


                  builder:  (context, state){
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
                               'Login or register ',
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
                           }else if(state is AccountLoaded){
                             User? user = BlocProvider.of<AccountCubit>(context).user;
                            return Card(
                                elevation: 8,
                        margin:const EdgeInsets.symmetric(horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // User Name
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Padding(
                                      padding:  EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    user!.name,
                                    style: TextStyle(fontSize: 18,
                                    color: Colors.black),
                                  ),
                                ],
                              ),
                            const  SizedBox(height: 16),
                              // Email
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child:const Padding(
                                      padding:  EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                const  SizedBox(width: 16),
                                  Text(
                                    user.email,
                                    style: TextStyle(fontSize: 18,
                                    color: Colors.black),
                                  ),
                                ],
                              ),
                            const  SizedBox(height: 16),
                              // Phone Number
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child:const Padding(
                                      padding:  EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                               const   SizedBox(width: 16),
                               const   Text(
                                    '123-456-7890',
                                    style: TextStyle(fontSize: 18,
                                    color: Colors.black),
                                  ),
                                ],
                              ),
                            const  SizedBox(height: 16),
                              // Message
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Padding(
                                      padding:  EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.message,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Text(
                                    'Leave a Message',
                                    style: TextStyle(fontSize: 18,
                                    color: Colors.black),
                                  ),
                                ],
                              ),
                             const  SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _showLogoutConfirmationDialog(context);
                                    },
                                    child:const Text('Logout'),
                                  ),
                               const   SizedBox(width: 16),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Modify'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                        }else{
                          return Column(
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
                         );;
                        }
                    });},
                 )
             ),
             ) 
          ],
        ),
      ),
    );
  }

  Future<String> getToken() async {
  String token = await MySharedPreference.getToken('token');
  
  return token ;
}
}

class _CustomBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.style = PaintingStyle.fill;
    var path = Path();
    var gradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.blue,
        Colors.white,
      ],
    );
    paint.shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    path.lineTo(0, size.height * 0.4);
    path.quadraticBezierTo(
        size.width / 2, size.height / 1.6, size.width, size.height * 0.4);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () async{
                ApiService api =ApiService();
               await api.logout(context);
                
              },
            ),
          ],
        );
      },
    );
  }
