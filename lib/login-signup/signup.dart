import 'package:edge_app/login-signup/login.dart';
import 'package:edge_app/models/usermodel.dart';
import 'package:edge_app/providers/logreg.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../api/url.dart';
import '../encryption/encrypt.dart';
import '../theme/themenotifier.dart';
import 'check verificationcode.dart';

class SignUp extends StatefulWidget {

  static const  String id='sign';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


  final _formKey=GlobalKey<FormState>();

  final _fi=TextEditingController();
  final _las=TextEditingController();
  final _phon=TextEditingController();
  final _coun=TextEditingController();
  final _add=TextEditingController();
  final _ema=TextEditingController();
  final _pass=TextEditingController();


  bool verifyButton=false;

  bool _secureText = true;
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  //
  // register() async {
  //   // controllers should not be empty to avoid send null values to the database
  //   if(
  //   _fi.text!='' && _las.text !=''
  //       && _phon.text!='' && _coun.text!=''
  //       && _add.text!='' && _ema.text!=''&& _pass.text!=''){
  //
  //     var response = await http.post(
  //         Uri.parse(
  //             BaseUrl.apiRegister),
  //
  //         //headers can be left out since CORS doesn't affect apps but it will affect A flutter web app,
  //         //so just to be safe include them.
  //         headers: {"Accept": "headers/json"},
  //         body: {
  //           "lname": encryp(_las.text),
  //           "fname": encryp(_fi.text),
  //           "phone": encryp(_phon.text),
  //           "count": encryp(_coun.text),
  //           "add": encryp(_add.text),
  //           "ema": encryp(_ema.text),
  //           "pass": encryp(_pass.text),
  //         });
  //
  //     setState(() async {
  //
  //       EasyLoading.show(status: 'Saving .....');
  //
  //       if (response.statusCode == 200) {
  //
  //         // decode json data passed in the http body
  //         var userData = json.decode(
  //             response.body);
  //
  //         if (userData == "ERROR") {
  //
  //           //choose another email.This one already exists
  //           ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(
  //                 content: const Text("Email already exists"),
  //                 backgroundColor: Colors.red.withOpacity(0.9),
  //                 elevation: 10, //shadow
  //               )
  //           );
  //
  //
  //         }
  //
  //         else if(userData=="REG"){
  //
  //           EasyLoading.showSuccess(' Saved...');
  //           ///verify otp code sent
  //           Navigator.pushNamed(context,CheckCode.id);
  //
  //           print(userData);
  //         }
  //       }
  //
  //
  //     });
  //
  //   }
  //
  //
  // }



  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemePro>(context);


    return WillPopScope(
        child:Scaffold(
          //resizeToAvoidBottomInset: false,
          backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade400:Colors.white,
          body: SafeArea(
              child:Form(
                key: _formKey,
                child: ListView(
                  padding:const EdgeInsets.only(left: 10,right: 10),
                  children:  [
                    const Padding(
                      padding: EdgeInsets.only(top: 30.0,bottom: 30),
                      child: Center(child: Text('REGISTER',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                    ),

                    // Center(
                    //   child: AnimatedTextKit(
                    //     animatedTexts: [
                    //       ColorizeAnimatedText(
                    //         'LOGIN',
                    //         textStyle:colorizeTextStyle,
                    //         colors:colorizeColors,
                    //       ),
                    //     ],
                    //
                    //   ),
                    // ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),

                        Image.asset('assets/images/logo.png',width: 115),

                        const SizedBox(height: 30,),
                      ],
                    ),


                    //first name
                    TextFormField(
                        controller: _fi,
                        cursorColor: Colors.blue.shade200,
                        decoration: InputDecoration(
                            hintText: 'First Name',
                            prefixIcon:Icon(Icons.person,size: 18,color:themeProvider.isDarkMode ? Colors.white: Colors.grey,),
                            filled: true,
                            fillColor: themeProvider.isDarkMode ? Colors.grey.shade500:Colors.grey.shade200,
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(color: Colors.blue),
                            )
                        ),

                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter your First Name';

                          }
                          return null;
                        }

                    ),

                    const SizedBox(height: 10,),

                    //lastname
                    TextFormField(
                        controller: _las,
                        cursorColor: Colors.blue.shade200,
                        decoration: InputDecoration(
                            hintText: 'Last Name',
                            prefixIcon: Icon(Icons.person,size: 18,color: themeProvider.isDarkMode ? Colors.white: Colors.grey,),
                            filled: true,
                            fillColor: themeProvider.isDarkMode ? Colors.grey.shade500:Colors.grey.shade200,
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(color: Colors.blue),
                            )
                        ),
                        validator: (value){
                          if(value!.isEmpty){

                            return 'Enter Last Name';
                          }
                          return null;

                        }
                    ),

                    const SizedBox(height: 10,),

                    //phone number
                    TextFormField(
                        controller: _phon,
                        cursorColor: Colors.blue.shade200,
                        decoration: InputDecoration(
                            hintText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone,size: 18,color: themeProvider.isDarkMode ? Colors.white: Colors.grey,),
                            filled: true,
                            fillColor: themeProvider.isDarkMode ? Colors.grey.shade500:Colors.grey.shade200,
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(color: Colors.blue),
                            )
                        ),

                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter your Phone Number';

                          }
                          return null;
                        }

                    ),

                    const SizedBox(height: 10,),

                    //country
                    TextFormField(
                        controller: _coun,
                        cursorColor: Colors.blue.shade200,
                        decoration: InputDecoration(
                            hintText: 'Country',
                            prefixIcon: Icon(CupertinoIcons.arrow_counterclockwise_circle_fill,size: 18,color: themeProvider.isDarkMode ? Colors.white: Colors.grey,),
                            filled: true,
                            fillColor: themeProvider.isDarkMode ? Colors.grey.shade500:Colors.grey.shade200,
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(color: Colors.blue),
                            )
                        ),
                        validator: (value){
                          if(value!.isEmpty){

                            return 'Enter Country';
                          }
                          return null;

                        }
                    ),

                    const SizedBox(height: 10,),

                    //address
                    TextFormField(
                        controller: _add,
                        cursorColor: Colors.blue.shade200,
                        decoration: InputDecoration(
                            hintText: 'Address',
                            prefixIcon: Icon(Icons.place,size: 18,color: themeProvider.isDarkMode ? Colors.white: Colors.grey,),
                            filled: true,
                            fillColor: themeProvider.isDarkMode ? Colors.grey.shade500:Colors.grey.shade200,
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(color: Colors.blue),
                            )
                        ),

                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter your Address';

                          }
                          return null;
                        }

                    ),

                    const SizedBox(height: 10,),

                    //email
                    TextFormField(
                        controller: _ema,
                        cursorColor: Colors.blue.shade200,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email,size: 18,color: themeProvider.isDarkMode ? Colors.white: Colors.grey,),
                            filled: true,
                            fillColor:themeProvider.isDarkMode ? Colors.grey.shade500:Colors.grey.shade200,
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(color: Colors.blue),
                            )
                        ),
                        validator: (value){
                          if(value!.isEmpty){

                            return 'Enter Email';
                          }
                          bool _isValid= (EmailValidator.validate(value));
                          if(_isValid==false){
                            return 'Enter Valid Email Address';

                          }
                          return null;

                        }
                    ),

                    const SizedBox(height: 10,),

                    //password
                    TextFormField(
                        controller: _pass,
                        cursorColor: Colors.blue.shade200,
                        obscureText: _secureText,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon:Icon(Icons.lock,size: 18,color: themeProvider.isDarkMode ? Colors.white: Colors.grey,),
                            suffixIcon: IconButton(
                              onPressed: showHide,
                              icon: _secureText
                                  ? const Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                                size: 20,
                              )
                                  : const Icon(
                                Icons.visibility,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                            filled: true,
                            fillColor: themeProvider.isDarkMode ? Colors.grey.shade500:Colors.grey.shade200,
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(color: Colors.blue),
                            )
                        ),

                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter your Password';

                          }
                          return null;
                        }

                    ),

                    const SizedBox(height: 10,),


                    //sign up
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20,right: 20),
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    //     onPressed: (){
                    //
                    //
                    //
                    //       if(_formKey.currentState!.validate()){
                    //
                    //         register();
                    //
                    //       }
                    //
                    //     }, child:const Text('Sign Up',style: TextStyle(color: Colors.white),),
                    //   ),
                    // ),



                    //sign up
                    Consumer<UserProvider>(
                        builder: (context, auth, child) {
                          WidgetsBinding.instance!.addPostFrameCallback((_) {

                            //Provider.of<UserProvider>(context,listen: false).registerUser(email:_ema.text, password:_pass.text, firstName:f, lastName: lastName, address: address, phone: phone, country: country);
                          });
                          return  Consumer<UserProvider>(
                              builder: (context, auth, child) {
                                WidgetsBinding.instance!.addPostFrameCallback((_) {

                                  //Provider.of<UserProvider>(context,listen: false).registerUser(email:_ema.text, password:_pass.text, firstName:f, lastName: lastName, address: address, phone: phone, country: country);
                                });
                                return Padding(
                                  padding: const EdgeInsets.only(left: 20,right: 20),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                    onPressed: (){



                                      if(_formKey.currentState!.validate()){

                                        if (_fi.text !='' ||
                                            _las.text !='' ||
                                            _phon.text !=''||
                                            _add.text !='' ||
                                            _ema.text !=''||
                                            _pass.text !=''||
                                            _coun.text !='') {


                                          //post edittext data to register function from the UserProvider
                                          auth.registerUser(
                                              firstName: _fi.text,
                                              lastName: _las.text,
                                              email: _ema.text,
                                              password: _pass.text,
                                              address:_add.text,
                                              phone:_phon.text,
                                              country:_coun.text,
                                              context: context);

                                          //set text fields to empty after
                                          _fi.text =='' ;
                                          _las.text =='' ;
                                          _phon.text =='';
                                          _add.text =='' ;
                                          _ema.text =='';
                                          _pass.text =='';
                                          _coun.text =='';

                                        }
                                      }

                                    }, child:const Text('Sign Up',style: TextStyle(color: Colors.white),),
                                  ),
                                );
                              });
                        }),

                    const SizedBox(height: 10,),


                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        onPressed: (){

                          Navigator.pushNamed(context, Login.id);

                        }, child:const Text('Already have account? Login',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                    //
                    // Consumer<UserProvider>(
                    //     builder:(context,auth,child){
                    //
                    //
                    //       if(auth.verifyButton){
                    //
                    //         return Align(
                    //             alignment: Alignment.center,
                    //             child: ElevatedButton(
                    //               style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    //               onPressed: (){
                    //
                    //
                    //               }, child:const Text('Verify Email',style: TextStyle(color: Colors.white),),
                    //             ),
                    //             );
                    //
                    //       }else{
                    //
                    //        return Align(
                    //             alignment: Alignment.centerLeft,
                    //             child:Container(),
                    //        );
                    //
                    //       }
                    //
                    //
                    //     }
                    // ),

                    const SizedBox(height: 50,),
                  ],
                ),
              )
          ),
        ),
      onWillPop:() async{

        return false;
      },
    );
  }
}
