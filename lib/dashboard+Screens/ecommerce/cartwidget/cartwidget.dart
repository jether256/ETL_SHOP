import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge_app/dashboard+Screens/dashboard.dart';
import 'package:edge_app/dashboard+Screens/ecommerce/homepro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../constants/cola.dart';
import '../../../providers/shopcartprovider.dart';
import '../../../sharedprefrences/usershare.dart';
import '../../../theme/themenotifier.dart';

class CartWidget extends StatefulWidget {



  const CartWidget({Key? key, }) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {

  final _formated= NumberFormat();


  bool _Online = false;

  bool positive = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Provider.of<ShoppingCartProvider>(context,listen: false).getAllCart();
    });
  }



  @override
  Widget build(BuildContext context) {

    var payment=Provider.of<ShoppingCartProvider>(context);

    final themeProvider = Provider.of<ThemePro>(context);


    Widget _stopBookingWidget() {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
        child: ListTile(
          title: const Text("Online or C.O.D payment",style: TextStyle(fontWeight: FontWeight.bold),),
          subtitle: _Online
              ? const Text("Turn off to use C.O.D")
              : const Text("Turn on to use online payment"),
          trailing: IconButton(
            icon:  _Online
                ? const Icon(
              Icons.toggle_on_outlined,
              color: Colors.green,
              size: 50,
            )
                : const Icon(
              Icons.toggle_off_outlined,
              color: Colors.red,
              size: 50,
            ),
            onPressed: () {
              setState(() {
                _Online= ! _Online;
              });
            },
          ),
        ),
      );
    }

    return  Column(
      children: [

        Expanded(
          child:Consumer<ShoppingCartProvider>(
            builder: (context,value,child){

              final pros=value.cart;

              if(value.isLoading){

                return ListView.builder(
                    itemBuilder:(context,index){


                      return Column(
                        children: [
                          Container(
                            height: 100,
                            padding: const EdgeInsets.all(5),
                            margin:const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)
                            ),
                            child: Row(
                              children: [
                                Image.asset('assets/images/hug.gif'),
                                const SizedBox(width: 10,),
                                Image.asset('assets/images/hug.gif'),
                                const SizedBox(width: 10,),
                                Image.asset('assets/images/hug.gif'),
                              ],
                            ),
                          ),
                        ],
                      );



                    }
                );

              }

              else if(value.noNet){

                return Container(
                    decoration:const BoxDecoration(
                      color: Colors.transparent,
                        image: DecorationImage(
                            image: AssetImage('assets/images/lost2.gif',),fit: BoxFit.cover
                        )

                    ),
                    child: Center(
                      child:Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Center(
                            child:Text('No internet Connection',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,) ,
                          ),

                          SizedBox(height: 20,),
                        ],
                      ),
                    )
                );
              }

              else{

                return pros.isEmpty ?  Container(
                    decoration:const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Empty_cart.png',),fit: BoxFit.cover
                        )

                    ),
                    child: Center(
                      child:Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child:Text('Cart is empty! Please continue shopping!!!!',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,) ,
                          ),

                          const SizedBox(height: 20,),

                          Container(
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
                              child:const Text("Shop",style: TextStyle(color: Colors.white),),
                              onPressed: () {


                                Navigator.pushNamed(context,Dashboard.id);
                              },
                            ),
                          ),
                          //
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          //   onPressed: (){
                          //
                          //     Navigator.pushNamed(context,Dashboard.id);
                          //
                          //   }, child:const Text('Shop',style: TextStyle(color: Colors.white),),
                          // ),
                        ],
                      ),
                    )
                ): ListView.builder(
                    itemCount: pros.length,
                    itemBuilder:(context,index){
                      var s_price=int.parse(pros[index].slp);
                      String sprice=_formated.format(s_price);

                      return Column(
                        children: [
                          Container(
                            height:140,
                            padding: const EdgeInsets.all(5),
                            margin:const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    CachedNetworkImage(
                                      imageUrl:'https://holomboko.000webhostapp.com/api/assets/images/products/${pros[index].im}',
                                      width:100,
                                      height:100,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width-183,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text(pros[index].name,style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                                          Row(
                                            children: [


                                              Consumer<ShoppingCartProvider>(
                                                  builder: (context, shop, child) {
                                                    WidgetsBinding.instance!.addPostFrameCallback((_) {

                                                      //Provider.of<UserProvider>(context,listen: false).registerUser(email:_ema.text, password:_pass.text, firstName:f, lastName: lastName, address: address, phone: phone, country: country);
                                                    });
                                                    return IconButton(
                                                        icon: const Icon(
                                                          Icons.add_circle,
                                                          color:Colors.green,
                                                        ),
                                                        onPressed: () {
                                                          shop.updateQuanity(catid:pros[index].id, quant: 'adding',context: context);
                                                        });
                                                  }),




                                              Text(pros[index].q,style: TextStyle(color:themeProvider.isDarkMode ? Colors.black:Colors.black ),),



                                              Consumer<ShoppingCartProvider>(
                                                  builder: (context, shop, child) {
                                                    WidgetsBinding.instance!.addPostFrameCallback((_) {

                                                      //Provider.of<UserProvider>(context,listen: false).registerUser(email:_ema.text, password:_pass.text, firstName:f, lastName: lastName, address: address, phone: phone, country: country);
                                                    });
                                                    return IconButton(
                                                        icon: const Icon(
                                                          Icons.remove_circle,
                                                          color: Colors.red,
                                                        ),
                                                        onPressed: () {
                                                          shop.updateQuanity( catid:pros[index].id, quant: 'sub',context:context);
                                                        });
                                                  }),



                                            ],
                                          ),
                                          // Text(
                                          //   "IDR " + price.format(int.parse(x.price)),
                                          //   style: boldTextStyle.copyWith(fontSize: 16),
                                          // ),
                                          Text('Price:${sprice} Shs',style:const TextStyle(color:Colors.black,fontSize: 15),)
                                        ],
                                      ),
                                    ),

                                    Consumer<ShoppingCartProvider>(
                                        builder: (context, shop, child) {
                                          WidgetsBinding.instance!.addPostFrameCallback((_) {

                                            //Provider.of<UserProvider>(context,listen: false).registerUser(email:_ema.text, password:_pass.text, firstName:f, lastName: lastName, address: address, phone: phone, country: country);
                                          });
                                          return IconButton(onPressed: (){

                                            shop.deleteCartItem(catid:pros[index].id, context:context);

                                          }, icon:const Icon(Icons.delete,color: Colors.red,));
                                        }),


                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );



                    }
                );
              }


            },
          ),
        ),
      ],
    );
  }
}
