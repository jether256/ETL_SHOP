
import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge_app/providers/my_order_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

import '../../../theme/themenotifier.dart';
import 'orders_detail.dart';

class MyOrdersAll extends StatefulWidget {
  const MyOrdersAll({Key? key}) : super(key: key);

  @override
  State<MyOrdersAll> createState() => _MyOrdersAllState();
}

class _MyOrdersAllState extends State<MyOrdersAll> {

  final _formated= NumberFormat();

  bool isLoggedIn=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MyOrdersProviders>(context,listen: false).getMyOrders();
    });


  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemePro>(context);


    return  Consumer<MyOrdersProviders>(
      builder: (context,value,child){

        final published=value.orders;

        if(value.isLoading){

          return GridView.builder(
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:2,
                childAspectRatio: 1/1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
              ),
              itemBuilder:(context,index){

                return Container(
                  decoration: BoxDecoration(
                      color:themeProvider.isDarkMode ? Colors.grey.shade500: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child:Image.asset('assets/images/hug.gif'),
                );



              }
          );

        }else{


          return ListView.builder(
              itemCount: published.length,
              itemBuilder:(context,index){

                var s_price=int.parse(published[index].amnt);
                String sprice=_formated.format(s_price);

                return Container(
                  color:themeProvider.isDarkMode ? Colors.grey.shade500 :Colors.grey.shade300,
                  child:Column(

                    children: [

                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.only(left:5,right: 5,top: 3,bottom: 3),
                        child:ListTile(
                          horizontalTitleGap: 0,
                          onTap: (){

                            Navigator.push(context,MaterialPageRoute(builder:(context)=>OrdersDetails(id:published[index].transid)));
                          },
                          leading:   CircleAvatar(
                            backgroundColor: Colors.lime.shade100,
                            radius: 14,
                            child: Icon(CupertinoIcons.square_list,size: 18,
                              color: published[index].status =='Rejected' ? Colors.red:
                              //published[index].status =='Rescheduled' ? Colors.amber[200]:
                              published[index].status =='Pending' ? Colors.grey:
                              //published[index].status =='Visited' ? Colors.green:
                              published[index].status =='Canceled' ? Colors.orange[700]:
                              published[index].status=='Confirmed' ? Colors.green[400]:Colors.orange,
                            ),
                          ),
                          title: Text(published[index].status,style:  TextStyle(fontSize: 12,
                              color: published[index].status =='Rejected' ? Colors.red:
                              //published[index].status =='Rescheduled' ? Colors.amber[200]:
                              published[index].status =='Pending' ? Colors.grey:
                              //published[index].status =='Visited' ? Colors.green:
                              published[index].status =='Canceled' ? Colors.orange[700]:
                              published[index].status=='Confirmed' ? Colors.green[400]:Colors.orange
                              ,fontWeight: FontWeight.bold),),
                          subtitle: Text(published[index].create),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Text('Order ID:${published[index].transid}',style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                              // published[index].onli=='false'?
                              // const Text('Payment Type:Cash on Delivery',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),):const Text('Payment Type:Paid Online',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                               const Text('Payment Type:Cash on Delivery',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                              Text('Amount:Shs${sprice}',style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                            ],
                          ),

                        ),
                      ),

                      //const Divider(height: 3,color: Colors.grey,),
                    ],
                  ) ,
                );
              }
          );
        }


      },
    );

  }
}
