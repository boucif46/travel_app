import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travello/cubit/account_cubit.dart';
import 'package:travello/cubit/travel_form_cubit.dart';
import 'package:travello/pages/main_page.dart';
import 'package:travello/services/api_services.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
 
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
          
            decoration:const  BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/intro2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    
                     
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration:const  InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(16),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                     const  SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration:const  InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(16),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                     
                     
                     const  SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final accountCubit = BlocProvider.of<AccountCubit>(context);
                              await accountCubit.getUserAccountFromLogin(
                                
                                _emailController.text,
                                _passwordController.text,
                             
                                
                              );

                              // Check if the user account has been loaded and navigate to the MainPage
                              if (accountCubit.isLoded) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                               
                              } else {
                                  const  Center(child:  CircularProgressIndicator());
                              }
                          }
                         
                           
                        },
                        child:const  Text('login'),
                      ),
                     const  SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                        
                        },
                        child:const  Text('Don\'t have an account? Register'),
                      ),
                    ],
                  ),
                ),
              ),
            ))),
            Positioned(
              top: 50,
              left: 20,
              child: GestureDetector(
                onTap: (){
                 Navigator.pop(context);
                   },
                child: Icon(Icons.arrow_back,color: Colors.white,size:30,)))
          ],
        )
        
        
        );
  }
}
