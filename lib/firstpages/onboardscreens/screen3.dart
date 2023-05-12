import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Screen3 extends StatefulWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.pink,

      child: Column(
        mainAxisSize: MainAxisSize.max,
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [

          const Spacer(),

          //Lottie anim
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Lottie.asset('assets/lot/gula.json',height:MediaQuery.of(context).size.height * 0.5),
          ),

          //Title
          const Text('Get Unlimited Support',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,
              color: Colors.white),),



          const Text('3/3',style: TextStyle(color: Colors.white),),
          const SizedBox(height: 50,),
        ],
      ),
    );
  }
}
