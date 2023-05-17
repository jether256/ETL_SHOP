import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/url.dart';
import '../../../login-signup/login.dart';
import '../../../providers/categoryproductprovider.dart';
import '../../../providers/catprovider.dart';
import '../../../providers/favoritepro.dart';
import '../../../providers/shopcartprovider.dart';
import '../../../theme/themenotifier.dart';
import '../productdetail/productdetail.dart';

class MainProCat extends StatefulWidget {



  @override
  State<MainProCat> createState() => _MainProCatState();
}

class _MainProCatState extends State<MainProCat> {

  final _formated= NumberFormat();

  bool isLoggedIn=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _checkLoginStatus();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoryProductProvider>(context,listen: false);
      Provider.of<FavouriteProvider>(context,listen: false);
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

    return Consumer<CategoryProductProvider>(
      builder:(context,value,child){

        final prodo=value.catpros;



        if(value.isLoading){

          return Expanded(
            flex: 1,
              child: GridView.builder(
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
              )
          );

        }else if(value.noNet){

          return Expanded(
              flex: 1,
              child: GridView.builder(
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
                      child:Image.asset('assets/images/lost2.gif'),
                    );



                  }
              )
          );


        }



        else{

          return Expanded(
            flex: 1,
              child: GridView.builder(
                  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:2,
                    childAspectRatio: 1/1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: prodo.length,
                  itemBuilder:(context,index){

                    var s_price=int.parse(prodo[index].selp);
                    String sprice=_formated.format(s_price);

                    return InkWell(
                      onTap: (){

                        Navigator.push(context,MaterialPageRoute(builder:(context) => ProductDetails(
                          id:prodo[index].id,nem:prodo[index].nem,regp:prodo[index].regp,selp:prodo[index].selp,catid:prodo[index].catid,disr:prodo[index].disr,ratin:prodo[index].ratin,
                          im1:prodo[index].im1,im2:prodo[index].im2,im3:prodo[index].im3,manid:prodo[index].manid,storeid:prodo[index].storeid,ava:prodo[index].ava,desc:prodo[index].desc,
                          promoid:prodo[index].promoid, create:prodo[index].create,subid:prodo[index].subid,modoid:prodo[index].modoid,fe:prodo[index].fe,retun:prodo[index].retun,
                          psdec:prodo[index].psdec,end:prodo[index].end,
                        )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color:themeProvider.isDarkMode ? Colors.grey.shade500 :Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child:Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl:'https://${BaseUrl.imUrl}${prodo[index].im1}',
                              //imageUrl:'https://holomboko.000webhostapp.com/api/assets/images/products/${prodo[index].im1}',
                             // imageUrl:'https://www.etl.co.ug/assets/images/products/${prodo[index].im1}',
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),

                            Consumer<FavouriteProvider>(
                                builder: (context, fav, child) {

                                  return Positioned(
                                    top: 0,
                                    left: 0,
                                    child: IconButton(icon:const Icon(CupertinoIcons.heart_fill,color:Colors.red),
                                      onPressed: () {

                                        isLoggedIn == false ? please():fav.AddFav(id:prodo[index].id, selp:prodo[index].selp,regp:prodo[index].regp,promoid:prodo[index].promoid,context:context);
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


                                        isLoggedIn == false ?  please():value.CartAdd(id:prodo[index].id, selp:prodo[index].selp,regp:prodo[index].regp,promoid:prodo[index].promoid,context:context);
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
                                padding: const EdgeInsets.only(left: 2.0,bottom: 2,top: 4),
                                child: Text(prodo[index].nem,maxLines:2,overflow:TextOverflow.ellipsis,textAlign: TextAlign.start,style: const TextStyle(fontSize:12),),
                              ),
                            ),

                          ],
                        ),
                      ),
                    );



                  }
              )
          );

        }

      },
    );
  }
}
