import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../api/url.dart';
import '../../../providers/my_order_pro.dart';
import '../../../providers/orderdetailsprovider.dart';
import '../../../providers/shopcartprovider.dart';
import '../../../theme/theme.dart';
import '../../../theme/themenotifier.dart';
import '../cartwidget/cartdialog.dart';

class OrdersDetails extends StatefulWidget {
  final String id;

  OrdersDetails({required this.id});

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {

  final _formated= NumberFormat();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Provider.of<ShoppingCartProvider>(context,listen: false).getCartCount();
      Provider.of<ShoppingCartProvider>(context,listen: false).getTotal();
      Provider.of<MyOrdersProviders>(context,listen: false);
      Provider.of<MyOrdersDetailsProviders>(context,listen: false).getMYODeatil(widget.id);

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
            title:const Text('Order Details',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white)),
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
            child:Consumer<MyOrdersDetailsProviders>(
              builder: (context,value,child){

                final published=value.deto;

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

                        var s_price=int.parse(published[index].up);
                        String sprice=_formated.format(s_price);

                        return Container(
                          //color:themeProvider.isDarkMode ? Colors.grey.shade500 :Colors.grey.shade300,
                          child:ListTile(
                            leading:Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: CachedNetworkImage(
                                imageUrl:'https://${BaseUrl.imUrl}${published[index].im}',
                                //imageUrl:'https://${BaseUrl.imUrl}/+${pros[index].im1}',
                               // imageUrl:'https://holomboko.000webhostapp.com/api/assets/images/products/${published[index].im}',fit:BoxFit.cover,
                                //imageUrl:'https://www.etl.co.ug/assets/images/products/${published[index].im}',fit: BoxFit.cover,
                              ) ,
                            ),
                            title: Text(published[index].name),
                            subtitle: Text('quantity: ${published[index].q}'),
                            trailing:Text('Shs:${sprice}'),
                        ),
                        );
                      }
                  );
                }


              },
            ),
          ),

        );
      },
    );
  }
}
