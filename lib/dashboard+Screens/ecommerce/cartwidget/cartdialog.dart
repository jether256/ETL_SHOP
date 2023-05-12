import 'dart:convert';
import 'package:edge_app/dashboard+Screens/ecommerce/shippingdetails/shipping.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../constants/cola.dart';
import '../../../providers/shopcartprovider.dart';
import '../../../theme/theme.dart';
import '../../../theme/themenotifier.dart';
import 'cartwidget.dart';

class CartDialog extends StatefulWidget {
  const CartDialog({Key? key}) : super(key: key);

  @override
  State<CartDialog> createState() => _CartDialogState();
}

class _CartDialogState extends State<CartDialog> {

  final _formated= NumberFormat();

  bool _Online = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Provider.of<ShoppingCartProvider>(context,listen: false).getTotal();

      Provider.of<ShoppingCartProvider>(context,listen: false).getCartCount();
    });
  }



  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemePro>(context);

    return Consumer<ShoppingCartProvider>(
        builder: (context,value,child){

          final pros=value.sumPrice;

          //var s_price=int.parse(pros as String);
          String sprice=_formated.format(pros);


          return Scaffold(
            appBar: AppBar(
              backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade700:mainColor,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
              title:const Text('Cart',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white)),
              actions:  [

                Consumer<ShoppingCartProvider>(
                    builder: (context,value,child){

                      final count=value.count;

                      return Padding(
                        padding:const EdgeInsets.only(top: 15,right: 20),
                        child:InkWell(
                          child:Badge(
                            label:count== null ? const Text('0',style: TextStyle(color: Colors.white,fontSize: 10),):Text('$count',style: const TextStyle(color: Colors.white,fontSize: 10),),
                            child:Icon(Icons.shopping_cart,color:whiteColor,) ,
                          ),
                          onTap: (){


                          },
                        ),
                      );
                    }),
              ],
            ),
            backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100],

            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: pros== null
                ? const SizedBox()
                : Container(
              padding: const EdgeInsets.all(15),
              height: 106,
              // margin: const EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              decoration:BoxDecoration(
                  color: Colors.green.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [


                  Consumer<ShoppingCartProvider>(
                      builder: (context,value,child){

                        final total=value.sumPrice;
                        //  //
                        //   String s_price=int.parse(total) as String;
                        String sprice=_formated.format(total);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            const Text(
                              "Total Payment",
                              style: TextStyle(
                                  fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
                            ),

                            Text(
                              sprice== null ? " Shs 0":"Shs $sprice",
                              style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
                            ),


                          ],
                        );

                      }),

                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      //color: Colors.green.shade700,
                      //shape: BoxShape.circle,
                      gradient:LinearGradient(
                        colors:[
                          blueGradient.darkShade,
                          blueGradient.lightShade,
                        ],
                      ),
                    ),
                    child:Consumer<ShoppingCartProvider>(
                      builder:(context,value,child){


                        //check out button
                        return Consumer<ShoppingCartProvider>(
                          builder: (context,out,child){

                            final total=out.sumPrice;

                            String sprice=_formated.format(total);

                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  colors:[
                                    blueGradient.darkShade,
                                    blueGradient.lightShade,
                                  ],
                                ),
                              ),
                              child:MaterialButton(
                                // color: Colors.green.shade700,
                                child:const Text("CHECKOUT NOW",style: TextStyle(color: Colors.white),),
                                onPressed: () {

                                 ///route to shipping details
                                  Navigator.pushNamed(context, ShippingDetails.id);

                                },
                              ) ,
                            );
                          },
                        );



                      },
                    ),
                  ),
                ],
              ),
            ),

            body: const Padding(
              padding: EdgeInsets.only(bottom: 70),
              child:CartWidget(),
            ),


          );
        });

  }
}
