import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/my_order_pro.dart';
import '../../../providers/shopcartprovider.dart';
import '../../../theme/theme.dart';
import '../../../theme/themenotifier.dart';
import '../cartwidget/cartdialog.dart';
import 'my_orders_all.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  final _formated= NumberFormat();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Provider.of<ShoppingCartProvider>(context,listen: false).getCartCount();

      Provider.of<MyOrdersProviders>(context,listen: false);

    });
  }



  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemePro>(context);



    return Consumer<MyOrdersProviders>(
        builder: (context,value,child){



          return Scaffold(
            appBar: AppBar(
              backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade700:mainColor,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
              title:const Text('My Orders',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white)),
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

                            ///to cart screen
                            Navigator.push(context,MaterialPageRoute(builder: (context)=> const CartDialog()));

                          },
                        ),
                      );
                    }),
              ],
            ),
            backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100],
            body:Container(
              height: MediaQuery.of(context).size.height,
              child:MyOrdersAll(),
            ),

          );
        });
  }
}
