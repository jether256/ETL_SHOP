
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import '../../../providers/my_order_pro.dart';
import '../../../providers/shopcartprovider.dart';
import '../../../theme/theme.dart';
import '../../../theme/themenotifier.dart';
import '../cartwidget/cartdialog.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {


  final _formated= NumberFormat();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Provider.of<MyOrdersProviders>(context,listen: false).getNoti();
      Provider.of<MyOrdersProviders>(context,listen: false).getOrderNotiCount();
      Provider.of<ShoppingCartProvider>(context,listen: false).getCartCount();
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
              title:const Text('Notifications',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white)),
              actions:  [

               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [

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


                   Consumer<MyOrdersProviders>(
                       builder: (context,value,child){

                         final co=value.count;

                         return Padding(
                           padding:const EdgeInsets.only(top: 15,right: 20),
                           child:InkWell(
                             child:Badge(
                               label:co == null ? const Text('0',style: TextStyle(color: Colors.white,fontSize: 10),):Text('$co',style: const TextStyle(color: Colors.white,fontSize: 10),),
                               child:Icon(Icons.notifications,color:whiteColor,) ,
                             ),
                             onTap: (){

                               ///to cart screen
                               ///Navigator.push(context,MaterialPageRoute(builder: (context)=> const CartDialog()));

                             },
                           ),
                         );
                       }),
                 ],
               )
              ],
            ),
            backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100],
            body:Container(
              height:MediaQuery.of(context).size.height,
              child:Consumer<MyOrdersProviders>(
                builder: (context,value,child){

                  final published=value.noti;

                  if(value.isLoading){

                    return ListView.builder(
                        itemBuilder:(context,index){
                          return Container(
                            decoration: BoxDecoration(
                                color:themeProvider.isDarkMode ? Colors.grey.shade500: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(4)
                            ),
                            child:Image.asset('assets/images/hug.gif',height: 200,),
                          );

                        }
                    );

                  }else{

                    return ListView.builder(
                        itemCount: published.length,
                        itemBuilder:(context,index){

                          var _convertedTimestamp = DateTime.parse(published[index].date); // Converting into [DateTime] object
                          var result = GetTimeAgo.parse(_convertedTimestamp);

                          return Consumer<MyOrdersProviders>(
                            builder: (context,value,child){

                              //final published=value.orders;



                              return Card(
                                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                  margin: const EdgeInsets.only(left:5,right: 5,top: 3,bottom: 3),
                                  child:ListTile(
                                      onTap: (){

                                        //post edittext data to login function from the UserProvider
                                        value.updateNoti(
                                            notid:published[index].id,
                                            context: context);
                                      },
                                      leading:   CircleAvatar(
                                        backgroundColor: Colors.lime.shade100,
                                        radius: 14,
                                        child:Image.asset('assets/images/logo.png'),
                                      ),
                                      title: Text(published[index].title,style:  const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),),
                                      subtitle: Text(published[index].body,style: TextStyle(color: Colors.white),),
                                      //trailing:Text(Jiffy(published[index].date).fromNow(),style: TextStyle(color: Colors.white),)
                                      trailing:Text(result,style: const TextStyle(color: Colors.white),),
                                  ));
                            },
                          );
                        }
                    );
                  }


                },
              ),
              //child:MyOrdersAll(),
            ),

          );
        });
  }
}
