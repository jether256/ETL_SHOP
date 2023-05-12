
import 'dart:async';

import 'package:edge_app/firstpages/onboard.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dashboard+Screens/dashboard.dart';
import '../login-signup/login.dart';
import '../sharedprefrences/usershare.dart';
import '../theme/theme.dart';
import '../theme/themenotifier.dart';


class SplashScreen extends StatefulWidget {

  static const  String id='splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final store = GetStorage();

  @override
  void initState() {
    // TODO: implement initState

    //delay for 5 seconds on the splash screen then move to on boarding screen or dashboard or dashboard logged
    Timer(const Duration(seconds: 3), () {

      //first time starting the app,app will check whether the user has already seen the onboarding screen
      //for that it should read get storage.
      //same as using shared prefrences
      //on onboarding value is null

       bool? _boarding=store.read('Boarding');

       // _boarding== null ? Navigator.pushReplacementNamed(context,OnBoarding.id):
       // _boarding== true ? Navigator.pushReplacementNamed(context,Dashboard.id):
       _boarding== true ? Dash():Bord();
      //
      // //Navigator.pushReplacementNamed(context,Login.id);
      // Navigator.pushReplacementNamed(context,OnBoarding.id);

    });
    super.initState();
  }


  //not the first time to run app skip onboard screen
  Dash() async{

    //getPref1();
    Navigator.pushReplacementNamed(context,Dashboard.id);
  }

  //not the first time to run app go to onboard screen
  Bord(){

    Navigator.pushReplacementNamed(context,OnBoarding.id);
  }


  //String? ID1;

  // getPref1() async{
  //   SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  //   setState(() {
  //
  //     //get id of user from shared preferences and check if its there or not
  //     ID1=sharedPreferences.getString(PrefInfo.id);
  //     if(ID1==null){
  //
  //       //to dashboard
  //       //when ever someone logs out they redirect from dashboard logged to dashboard.
  //       sessionLogout();
  //
  //     }else{
  //
  //       //loggedin to DashboardLogged
  //       sessionLogin();
  //
  //
  //     }
  //
  //
  //   });
  // }

  // sessionLogout() {
  //   Navigator.pushReplacementNamed(context,Dashboard.id);
  // }
  //
  // sessionLogin() {
  //
  //   Navigator.pushReplacementNamed(context,Dashboard.id);
  // }


  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemePro>(context);

    return  Scaffold(
      backgroundColor:themeProvider.isDarkMode ? Colors.grey.shade100:whiteColor,
      body: SafeArea(
          child:Container(
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //     opacity: 100,
              //     image: AssetImage("assets/images/favi.png"),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              child:  Padding(
                padding: const EdgeInsets.only(left:20,right: 20),
                child: Center(child: Image.asset('assets/images/logo.png',height:200,)),
              )
          ),
      ),
    );
  }
}
