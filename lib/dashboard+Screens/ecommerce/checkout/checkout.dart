
import 'package:edge_app/dashboard+Screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/cola.dart';
import '../../../providers/shopcartprovider.dart';
import '../../../theme/theme.dart';
import '../../../theme/themenotifier.dart';

class Checkout extends StatefulWidget {

  static const  String id='checkout';

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {


  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemePro>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100],
        appBar:AppBar(
          backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade700:mainColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title:const Text('Order Success',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white)),
        ),
        body:ListView(
          children: [
            Center(
              child: Column(
                children: [

                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/images/logo.png",
                    width: 115,
                  ),
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(24),
                    children: [
                      const SizedBox(
                        height: 60,
                      ),

                      Column(
                        children: [
                          Image.asset(
                            'assets/images/successful.png',
                            width: 250,
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          const Text(
                            "Your order was successful",
                            style:TextStyle(fontSize: 25),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(
                            height: 16,
                          ),

                          Text(
                            'continue shopping',
                            style:TextStyle(
                                fontSize: 15, color: greyLightColor),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                        ],
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                              colors:[
                                blueGradient.darkShade,
                                blueGradient.lightShade,
                              ],
                            ),
                          ),
                          child: MaterialButton(
                            //color: Colors.green.shade700,
                            child:const Text("Continue shopping",style: TextStyle(color: Colors.white),),
                            onPressed: () {

                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                              //Navigator.pushNamed(context, Dashboard.id);
                              Navigator.pushReplacementNamed(context,Dashboard.id);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
