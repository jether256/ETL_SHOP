import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge_app/providers/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api/services/ecom.dart';
import '../../../api/url.dart';
import '../../../login-signup/login.dart';
import '../../../models/productmodel.dart';
import '../../../providers/favoritepro.dart';
import '../../../providers/shopcartprovider.dart';
import '../../../theme/theme.dart';
import '../../../theme/themenotifier.dart';
import '../productdetail/productdetail.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {

  TextEditingController searchController = TextEditingController();

  List<ProductModel> listProduct = [];
  List<ProductModel> listSearchProduct = [];



  final _formated= NumberFormat();


  bool isLoggedIn=false;


  @override
  void initState() {


    super.initState();

    _checkLoginStatus();
    getProduct();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Provider.of<ProductProvider>(context,listen: false).getAllProducts();
      Provider.of<ProductProvider>(context,listen: false);
      Provider.of<FavouriteProvider>(context,listen: false);
      Provider.of<ShoppingCartProvider>(context,listen: false);
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


  getProduct() async {
    listProduct.clear();
    var urlProduct = Uri.parse(BaseUrl.getProduct);
    final response = await http.get(urlProduct);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map product in data) {
          listProduct.add(product as ProductModel);
        }
      });
    }
  }

  searchProduct(String text) {
    listSearchProduct.clear();
    if (text.isEmpty) {
      setState(() {});
    } else {
      listProduct.forEach((element) {
        if (element.nem.toLowerCase().contains(text)) {
          listSearchProduct.add(element);
        }
      });
      setState(() {});
    }
  }

  please(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            //backgroundColor:themeProvider.isDarkMode ? Colors.grey.shade500 :Colors.grey.shade300,
            title: const Text('Welcome '),
            content: const Text('Please Login first to continue'),
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
          ),
        );
      },
    );

  }


  @override
  Widget build(BuildContext context) {


    final themeProvider = Provider.of<ThemePro>(context);

   return Scaffold(
     backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade700:mainColor,
      body: SafeArea(
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        size: 32,
                        color:Colors.green,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      width: MediaQuery.of(context).size.width - 100,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffe4faf0)),
                      child: Consumer<ProductProvider>(
                        builder:(context,value,child){


                         // final search=value.;

                          return TextField(
                            onChanged: value.searchProduct(text:searchController.text),
                            controller: searchController,
                            autofocus: true,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xffb1d8b2),
                                ),
                                hintText: "Search product ...",
                                hintStyle: TextStyle(
                                    color: Color(0xffb0d8b2))),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Consumer<ProductProvider>(
                builder: (context,value,child){

                  return searchController.text.isEmpty || listSearchProduct.length == 0
                      ? Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/nodata.png',
                          width: 250,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'There is product not found',
                          style:TextStyle(fontSize: 25),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(
                          height: 16,
                        ),

                      ],
                    ),
                  )
                      : Container(
                    padding: const EdgeInsets.all(24),
                    child: GridView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: listSearchProduct.length,
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16),
                        itemBuilder: (context, index) {

                          var s_price=int.parse( listSearchProduct[index].selp);
                          String sprice=_formated.format(s_price);

                          return InkWell(
                            onTap: (){

                              Navigator.push(context,MaterialPageRoute(builder:(context) => ProductDetails(
                                id: listSearchProduct[index].id,nem: listSearchProduct[index].nem,regp: listSearchProduct[index].regp,selp: listSearchProduct[index].selp,catid: listSearchProduct[index].catid,disr: listSearchProduct[index].disr,ratin: listSearchProduct[index].ratin,
                                im1: listSearchProduct[index].im1,im2: listSearchProduct[index].im2,im3: listSearchProduct[index].im3,manid: listSearchProduct[index].manid,storeid: listSearchProduct[index].storeid,ava: listSearchProduct[index].ava,desc: listSearchProduct[index].desc,
                                promoid: listSearchProduct[index].promoid, create: listSearchProduct[index].create,subid: listSearchProduct[index].subid,modoid: listSearchProduct[index].modoid,fe: listSearchProduct[index].fe,retun: listSearchProduct[index].retun,
                                psdec: listSearchProduct[index].psdec,end: listSearchProduct[index].end,
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
                                    imageUrl:'https://${BaseUrl.imUrl}${listSearchProduct[index].im1}',
                                    //imageUrl:'https://holomboko.000webhostapp.com/api/assets/images/products/${listSearchProduct[index].im1}',
                                    //imageUrl:'https://www.etl.co.ug/assets/images/products/${listSearchProduct[index].im1}',
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

                                              isLoggedIn == false ? please():fav.AddFav(id:listSearchProduct[index].id, selp:listSearchProduct[index].selp,regp:listSearchProduct[index].regp,promoid:listSearchProduct[index].promoid,context:context);
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


                                              isLoggedIn == false ?  please():value.CartAdd(id:listSearchProduct[index].id, selp:listSearchProduct[index].selp,regp:listSearchProduct[index].regp,promoid:listSearchProduct[index].promoid,context:context);
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
                                      child: Text(listSearchProduct[index].nem,maxLines:2,overflow:TextOverflow.ellipsis,textAlign: TextAlign.start,style: const TextStyle(fontSize:12),),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );
                        }),
                  );
                },
              ),
            ],
          )),
    );
  }
}
