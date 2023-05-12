import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.purple,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          const Spacer(),

          //Lottie anim
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Lottie.asset('assets/lot/buy.json',height:MediaQuery.of(context).size.height * 0.5),
          ),

          //title
          const Text('Shop ICT Equipment of all Kind',textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,
              color: Colors.white),),

          Text(''),

          const Text('2/3',style: TextStyle(color: Colors.white),),
          const SizedBox(height: 50,),
        ],
      ),
    );
  }
}
