
import 'dart:convert';

import 'package:edge_app/dashboard+Screens/dashboard.dart';
import 'package:edge_app/login-signup/signup.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api/url.dart';
import '../encryption/encrypt.dart';
import '../providers/logreg.dart';
import '../sharedprefrences/usershare.dart';
import '../theme/themenotifier.dart';
import 'checkmail.dart';
import 'forgotpass.dart';


class Login extends StatefulWidget {

  static const  String id='log';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();

  final _ema = TextEditingController();
  final _pass = TextEditingController();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }


  // final Map<String, dynamic> data= {
  //   'ema': encryp(email),
  //   'pass':encryp(password),
  // };



  login() async {




    // var response = await http.post(Uri.parse(BaseUrl.apiLogin),
    //     //headers can be left out since CORS doesn't affect apps but it will affect A flutter web app,
    //     //so just to be safe include them.
    //     headers: {"Accept": "headers/json"},
    //     body: {
    //       "ema": encryp(_ema.text),
    //       "pass": encryp(_pass.text),
    //     });
    //
    //
    // if (response.statusCode == 200) {
    //   var userData = json.decode(response.body);
    //
    //   String ID = userData['cust_id'];
    //   String fnem = userData['cust_fname'];
    //   String lnem = userData['cust_lname'];
    //   String mail = userData['cust_email'];
    //   String phon = userData['cust_phone'];
    //   String loc = userData['cust_location'];
    //   String pic = userData['cust_photo'];
    //   String pass = userData['cust_password'];
    //   String con = userData['cust_country'];
    //   String date = userData['cust_created_on'];
    //
    //
    //   if (userData == "ERROR") {
    //     EasyLoading.showError('Login Failed..');
    //   } else {
    //
    //     savePref(ID, fnem, lnem, mail, phon, loc, pic, pass, con, date);
    //
    //     EasyLoading.showSuccess(' Logged in...');
    //
    //
    //
    //
    //
    //     //route to Login Screen
    //
    //
    //     if (mounted) {
    //       //Navigator.push(context,MaterialPageRoute(builder:(context)=>const DashLogged()));
    //       //Navigator.pushReplacementNamed(context, .id);
    //       Navigator.pushReplacementNamed(context, Dashboard.id);
    //     }
    //
    //
    //     print(userData);
    //   }
    // }


  }



  //save prefs
  // savePref(String ID, String fnem, String lnem, String mail, String phon,
  //     String loc, String pic, String pass,
  //     String con, String date) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //
  //   setState(() {
  //     sharedPreferences.setString(PrefInfo.id, ID);
  //     sharedPreferences.setString(PrefInfo.fnem, fnem);
  //     sharedPreferences.setString(PrefInfo.lnem, lnem);
  //     sharedPreferences.setString(PrefInfo.mail, mail);
  //     sharedPreferences.setString(PrefInfo.phon, phon);
  //     sharedPreferences.setString(PrefInfo.loc, loc);
  //     sharedPreferences.setString(PrefInfo.phot, pic);
  //     sharedPreferences.setString(PrefInfo.pass, pass);
  //     sharedPreferences.setString(PrefInfo.count, con);
  //     sharedPreferences.setString(PrefInfo.create, date);
  //   });
  // }





  @override
  Widget build(BuildContext context) {


    final themeProvider = Provider.of<ThemePro>(context);


    return Scaffold(
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
                  child: Center(child: Text('LOGIN',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))),
                ),



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


                //email textfield
                TextFormField(
                  controller: _ema,
                  cursorColor: Colors.blue.shade200,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon:Icon(Icons.email,size: 18,color: themeProvider.isDarkMode ? Colors.white: Colors.grey,),
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


                //password textfiled
                TextFormField(
                  controller: _pass,
                  cursorColor: Colors.blue.shade200,
                    obscureText: _secureText,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock,size: 18,color: themeProvider.isDarkMode ? Colors.white: Colors.grey,),
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
                        return 'Enter your Password';

                      }
                      return null;
                    }

                ),

                const SizedBox(height: 10,),

                 Align(
                  alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const CheckMail()));

                        //EasyLoading.showSuccess('Forgot password clicked.....');

                      },
                      child:  Text('Forgot password?',style: TextStyle(color:themeProvider.isDarkMode ? Colors.white: Colors.blue),
                      ),
                    )),

                const SizedBox(height: 20,),

                Consumer<UserProvider>(
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

                                        //continue if the textfields are not empty
                                        if (
                                            _ema.text !=''||
                                            _pass.text !=''
                                        ) {


                                          //post edittext data to login function from the UserProvider
                                          auth.loginUser(
                                              email: _ema.text,
                                              password: _pass.text,
                                              context: context);

                                          //set text fields to empty after
                                          _ema.text =='';
                                          _pass.text =='';


                                        }


                                      }

                          }, child:const Text('Login',style: TextStyle(color: Colors.white),),
                        ),
                      );
                    }),

                const SizedBox(height: 20,),

                Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: (){

                        //EasyLoading.showSuccess('Sign Up Clicked...');
                        Navigator.pushReplacementNamed(context,SignUp.id);

                      },
                      child:   Text('Dont have an account? ${'Sign Up'}',style: TextStyle(color:themeProvider.isDarkMode ? Colors.white: Colors.blue),
                      ),
                    )),

                const SizedBox(height: 50,),
              ],
            ),
          )
      ),
    );
  }
}


