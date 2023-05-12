import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.teal,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          const Spacer(),

          //lottie anim
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Lottie.asset('assets/lot/shop.json',height:MediaQuery.of(context).size.height * 0.5),
          ),

          //Title
          const Text('Shop ICT Equipment of all Kind',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,
              color: Colors.white),),

          Text(''),

          const Text('1/3',style: TextStyle(color: Colors.white),),

          const SizedBox(height: 50,),
        ],
      ),
    );
  }
}
