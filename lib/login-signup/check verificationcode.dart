import 'package:edge_app/login-signup/signup.dart';
import 'package:edge_app/providers/logreg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

import '../theme/themenotifier.dart';
import 'input.dart';

class CheckCode extends StatefulWidget {

  final String mail;

  CheckCode({required this.mail});


  static const  String id='mail-otp';

  @override
  State<CheckCode> createState() => _CheckCodeState();
}

class _CheckCodeState extends State<CheckCode> {


  final _formKey = GlobalKey<FormState>();


  // 4 text editing controllers that associate with the 4 input fields
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();

  // This is the entered code
  // It will be displayed in a Text widget
  String? _otp;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Provider.of<UserProvider>(context,listen: false);

    });


  }


  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemePro>(context);
    final _userProvider=Provider.of<UserProvider>(context);


    return WillPopScope(
        child: Scaffold(
          //resizeToAvoidBottomInset: false,
          backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade400:Colors.white,
          body:Consumer<UserProvider>(
              builder: (context,auth,child){

                return Form(
                  key: _formKey,
                  child: ListView(
                    padding:const EdgeInsets.only(left: 10,right: 10,top: 30),
                    children:  [
                      const Padding(
                        padding: EdgeInsets.only(top: 30.0,bottom: 20),
                        child: Center(child: Text('Check Mail Verification Code',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(top: 10.0,bottom: 10,right: 10,left: 10),
                        child: Center(child: Text('Please enter digit code sent to your Email',style: TextStyle(fontSize: 18))),
                      ),
                      //
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),

                          Image.asset('assets/images/logo.png',width: 115),

                          const SizedBox(height: 30,),
                        ],
                      ),


                      // Implement 4 input fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OtpInput(_fieldOne, true), // auto focus
                          OtpInput(_fieldTwo, false),
                          OtpInput(_fieldThree, false),
                          OtpInput(_fieldFour, false),
                          OtpInput(_fieldFive, false),
                        ],
                      ),


                      const SizedBox(height: 30,),
                      //
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child:Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            onPressed: (){


                              setState(() {

                                _otp = _fieldOne.text + _fieldTwo.text + _fieldThree.text + _fieldFour.text + _fieldFive.text;

                                if(_formKey.currentState!.validate()){

                                  auth.verifyOtp(email:widget.mail,code:_otp!, context: context);
                                  //auth.verifyOtp(email:_userProvider.maile,code:_otp!, context: context);


                                }


                              });




                            }, child:const Text('Confirm',style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20,),
                      //
                      // TextButton(onPressed:(){
                      //   Navigator.pushNamed(context,SignUp.id);
                      // }, child:const Text('Back to Signup',style: TextStyle(fontSize: 18),)),
                      const SizedBox(height: 50,),
                    ],
                  ),
                );

              }),
        ),
      onWillPop:() async{

        return false;
      },
    );
  }
}
