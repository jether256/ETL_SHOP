import 'package:edge_app/dashboard+Screens/dashboard.dart';
import 'package:edge_app/firstpages/onboardscreens/screen1.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'onboardscreens/screen2.dart';
import 'onboardscreens/screen3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {

  static const  String id='on-board';

  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final store = GetStorage();



  // the Three onboard screens
  final pages=[
    const Screen1(),
    const Screen2(),
    const Screen3(),

  ];

  final contro=LiquidController();

  int currentPage=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [

          LiquidSwipe(
            pages:pages,
            liquidController: contro,
            onPageChangeCallback: onPage,
            slideIconWidget: const Icon(Icons.arrow_back_ios,color:Colors.white,),
            enableSideReveal: true,
          ),

          Positioned(
            bottom: 30,
                  left: 8,
              child:OutlinedButton(
                onPressed: () {
                  //
                  int nextp=contro.currentPage+1;
                  contro.animateToPage(page: nextp);




                },
                style:ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.black26),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                  onPrimary: Colors.white,
                ),
                child:Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xff272727),shape: BoxShape.circle
                  ),
                  child: const Icon(Icons.arrow_forward_ios),
                ),

              )
          ),

          Positioned(
            top: 50,
              right: 20,
              child:TextButton(
                  onPressed:() async {

                    //now change onboard value to true;
                    
                    store.write('Boarding', true);

                    //contro.jumpToPage(page: 2);

                    //Navigator.pushReplacementNamed(context,DashBoard.id);




                      Navigator.push(context,PageTransition(child: Dashboard(), type:PageTransitionType.fade));




                    //now value should change to true if we restart.

                  },
                  child:const Text('Skip',style: TextStyle(color: Colors.white),)
              ),
          ),

          Positioned(
            bottom: 10,
              child:AnimatedSmoothIndicator(
                activeIndex:contro.currentPage,
                count:3,
                effect: const WormEffect(
                  activeDotColor: Color(0xff272727),
                  dotHeight:5.0,
                ),
              ),
          ),

        ],
      ),
    );
  }

 void onPage(int activePageIndex) {


   setState(() {

     currentPage=activePageIndex;
   });

 }




}
