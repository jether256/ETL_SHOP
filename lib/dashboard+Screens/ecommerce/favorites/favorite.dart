
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/url.dart';
import '../../../login-signup/login.dart';
import '../../../providers/favoritepro.dart';
import '../../../providers/shopcartprovider.dart';
import '../../../theme/theme.dart';
import '../../../theme/themenotifier.dart';
import '../cartwidget/cartdialog.dart';
import '../productdetail/productdetail.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  final _formated= NumberFormat();

  bool isLoggedIn=false;

  @override
  void initState() {


    super.initState();

    _checkLoginStatus();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Provider.of<ShoppingCartProvider>(context,listen: false).getCartCount();
      Provider.of<ShoppingCartProvider>(context,listen: false);
      Provider.of<FavouriteProvider>(context,listen: false).getAllFav();
    });

  }


  _checkLoginStatus() async {
    SharedPreferences localStorage= await SharedPreferences.getInstance();
    var Id=localStorage.getString('cust_id');

    if(Id != null){

      setState(() {
        isLoggedIn=true;
      });

    }

  }



  please(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:Colors.cyan.withOpacity(0.8),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/images/logo.png',height: 50,width: 50,)
            ],
          ),
          content: const Text('Please Login first to continue',style:TextStyle(color:Colors.white),),
          actions: [
            MaterialButton(
              color: Colors.blue,
              //hoverColor: Colors.green,
              textColor: Colors.white,
              onPressed: () {

                Navigator.pushReplacementNamed(context, Login.id);
              },
              child: const Text('Login'),
            ),
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {

                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );

  }





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
          actions: [


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
          title:const Text('Favorites',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white)),
        ),
        body:Padding(
          padding: const EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0),
          child:Consumer<FavouriteProvider>(
            builder: (context,value,child){

              final pros=value.fav;

              if(value.isLoading){

                return  GridView.builder(
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
                        child:Image.asset('assets/images/hug.gif',height: 200,),
                      );

                    }
                );

              }else{


                return GridView.builder(
                    itemCount: pros.length,
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:2,
                      childAspectRatio: 1/1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder:(context,index){

                      var s_price=int.parse(pros[index].slp);
                      String sprice=_formated.format(s_price);

                      return InkWell(
                        onTap: (){

                          // Navigator.push(context,MaterialPageRoute(builder:(context) => ProductDetails(
                          //   id:pros[index].id,nem:pros[index].nem,regp:pros[index].regp,selp:pros[index].selp,catid:pros[index].catid,disr:pros[index].disr,ratin:pros[index].ratin,
                          //   im1:pros[index].im1,im2:pros[index].im2,im3:pros[index].im3,manid:pros[index].manid,storeid:pros[index].storeid,ava:pros[index].ava,desc:pros[index].desc,
                          //   promoid:pros[index].promoid, create:pros[index].create,subid:pros[index].subid,modoid:pros[index].modoid,fe:pros[index].fe,retun:pros[index].retun,
                          //   psdec:pros[index].psdec,end:pros[index].end,
                          // )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color:themeProvider.isDarkMode ? Colors.grey.shade500 :Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(4)
                          ),
                          child:Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl:'https://${BaseUrl.imUrl}${pros[index].im}',
                                //imageUrl:'https://holomboko.000webhostapp.com/api/assets/images/products/${pros[index].im}',
                                //imageUrl:'https://www.etl.co.ug/assets/images/products/${pros[index].im}',
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),



                              Consumer<FavouriteProvider>(
                                  builder: (context, fav, child) {

                                    return Positioned(
                                      top: 0,
                                      left: 0,
                                      child: IconButton(icon:const Icon(CupertinoIcons.delete,color:Colors.red),
                                        onPressed: () {

                                          isLoggedIn == false ? please():fav.deleteFavItem(context:context, catid:pros[index].id);
                                        },
                                      ),
                                    );
                                  }),

                              Consumer<ShoppingCartProvider>(
                                  builder: (context,value,child){


                                    return Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(icon:Icon(CupertinoIcons.shopping_cart,color:themeProvider.isDarkMode ? Colors.grey.shade900:Colors.black,),
                                        onPressed: () {


                                          isLoggedIn == false ?  please():value.CartAdd(id:pros[index].id, selp:pros[index].slp,regp:pros[index].rp,promoid:pros[index].promid,context:context);
                                        },
                                      ),
                                    );
                                  }),




                              Positioned(
                                bottom: 43,
                                left:2,
                                child:  Text('Shs ${sprice}',maxLines:2,overflow:TextOverflow.ellipsis,textAlign: TextAlign.start,style: TextStyle(color:themeProvider.isDarkMode ? Colors.grey.shade900:Colors.black,fontSize: 17,fontWeight: FontWeight.bold
                                ),),
                              ),

                              Positioned(
                                bottom: 2,
                                left: 2,
                                right: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2.0,bottom: 2,top: 2),
                                  child: Text(pros[index].name,maxLines:2,overflow:TextOverflow.ellipsis,textAlign: TextAlign.start,style: const TextStyle(fontSize:14 ),),
                                ),
                              ),

                            ],
                          ),
                        ),
                      );



                    }
                );
              }


            },
          ),
        ),
      ),
    );
  }
}
