import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:edge_app/dashboard+Screens/dashboard.dart';
import 'package:edge_app/dashboard+Screens/ecommerce/homepagewidgets/featuredwidget.dart';
import 'package:edge_app/dashboard+Screens/ecommerce/orders/notifications.dart';
import 'package:edge_app/dashboard+Screens/ecommerce/productdetail/productdetail.dart';
import 'package:edge_app/dashboard+Screens/ecommerce/search/search.dart';
import 'package:edge_app/encryption/encrypt.dart';
import 'package:edge_app/providers/logreg.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/url.dart';
import '../../constants/cola.dart';
import '../../login-signup/login.dart';
import '../../providers/my_order_pro.dart';
import '../../providers/shopcartprovider.dart';
import '../../theme/theme.dart';
import '../../theme/themenotifier.dart';
import 'cartpro.dart';
import 'cartwidget/cartdialog.dart';
import 'homepagewidgets/banner.dart';
import 'homepagewidgets/cartwidget.dart';
import 'homepagewidgets/clientslider.dart';
import 'homepagewidgets/proei.dart';
import 'morefeatured&latestproducts/morefeatured.dart';
import 'morefeatured&latestproducts/morelatest.dart';
import 'package:http/http.dart' as http;

class HomeProduct extends StatefulWidget {
  static const  String id='home-pro';

  const HomeProduct({Key? key}) : super(key: key);

  @override
  State<HomeProduct> createState() => _HomeProductState();
}

class _HomeProductState extends State<HomeProduct> {


  String? ID,fnem,lnem,mail,phone,locat,pic,pass,count,date;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      ID= sharedPreferences.getString("cust_id");
      fnem= sharedPreferences.getString("cust_fname");
      lnem= sharedPreferences.getString("cust_lname");
      mail= sharedPreferences.getString("cust_email");
      pic= sharedPreferences.getString("cust_phone");
      locat= sharedPreferences.getString("cust_location");
      pic= sharedPreferences.getString("cust_photo");
     pass = sharedPreferences.getString("cust_password");
      count= sharedPreferences.getString("cust_country");
     date = sharedPreferences.getString("cust_created_on");

    });
  }
  bool isLoggedIn=false;

  @override
  void initState() {
    super.initState();

    getPref();
    _checkLoginStatus();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Provider.of<ShoppingCartProvider>(context,listen: false).getCartCount();
      Provider.of<MyOrdersProviders>(context,listen: false).getOrderNotiCount();
    });

    showProducts();
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


  lougOut() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();


    String? UID=sharedPreferences.getString("cust_id");
    FirebaseMessaging.instance.unsubscribeFromTopic("users");
    FirebaseMessaging.instance.unsubscribeFromTopic("users${UID}");


    sharedPreferences.remove("cust_id");
    sharedPreferences.remove("cust_fname");
    sharedPreferences.remove("cust_lname");
    sharedPreferences.remove("cust_email");
    sharedPreferences.remove("cust_phone");
    sharedPreferences.remove("cust_location");
    sharedPreferences.remove("cust_photo");
    sharedPreferences.remove("cust_password");
    sharedPreferences.remove("cust_country");
    sharedPreferences.remove("cust_created_on");




    if(mounted){
      Navigator.pushReplacementNamed(context, Dashboard.id);
    }

  }

  late  List searchList=[];
  showProducts() async{

    var response = await http.get(Uri.parse(BaseUrl.getProduct),
        headers:{"Accept":"headers/json"});
    if(response.statusCode ==200){

      var jsonData=json.decode(response.body);

      for(var i=0;i<jsonData.length;i++){
        //searchList.add(jsonData[i]['psale_price']);
        //searchList.add(jsonData[i]['pimage1']);
        //searchList.add(jsonData[i]['psdescription']);
        searchList.add(jsonData[i]['pname']);
      }
      print(searchList);
      //return jsonData;

    }

  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemePro>(context);






     return SafeArea(
      child: Scaffold(
        backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100],
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          floatHeaderSlivers: true,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled){

            return  <Widget>[

              SliverAppBar(
                //leading: IconButton(icon:const Icon(Icons.menu), onPressed: () {  },),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Image.asset("assets/images/logo.png",height: 40,width: 40,),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background:Image.asset("assets/images/print.gif",fit: BoxFit.cover,),
                ),
                expandedHeight: 200.0,
                pinned: true,
                stretch: true,
                actions: [


                  Consumer<MyOrdersProviders>(
                      builder: (context,value,child){

                        final count=value.count;
                        //
                        return Padding(
                          padding:const EdgeInsets.only(top: 15),
                          child:InkWell(
                            child:Badge(
                              label:count== null ? const Text('0',style: TextStyle(color: Colors.white,fontSize: 10),):Text('$count',style: const TextStyle(color: Colors.white,fontSize: 10),),
                              child:Icon(Icons.notifications,color:whiteColor,) ,
                            ),
                            onTap: (){

                              ///to notifications page
                              Navigator.push(context,MaterialPageRoute(builder: (context)=> const NotificationsPage()));

                            },
                          ),
                        );

                      }),

                  const SizedBox(width: 15,),

                  Consumer<ShoppingCartProvider>(
                      builder: (context,value,child){

                        final count=value.count;

                        return Padding(
                          padding:const EdgeInsets.only(top: 15),
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

                  const SizedBox(width: 15,),

                  ID == null ? IconButton(icon:const Icon(Icons.account_circle_outlined), onPressed: () {

                    Navigator.push(context,MaterialPageRoute(builder:(BuildContext context){
                      return Login();
                    }));




                  },):IconButton(icon:const Icon(Icons.logout), onPressed: () {


                    lougOut();




                  },),





                ],
                elevation: 0,
                centerTitle: true,
                backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade700:mainColor,
                bottom:  PreferredSize(
                  preferredSize: const Size.fromHeight(56),
                  child:Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [

                        Row(
                          children: [

                            Expanded(
                              child:Container(
                                child:TextField(
                                  onTap: (){

                                    showSearch(context: context, delegate:SearchAds(list:searchList));

                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Search a product',
                                    prefixIcon: Icon(Icons.search,color:themeProvider.isDarkMode ? Colors.white: Colors.grey ,),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    filled: true,
                                    fillColor:themeProvider.isDarkMode ? Colors.grey.shade500:Colors.grey.shade200,
                                  ),

                                ),
                              ),
                            ),


                          ],
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          height: 20,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              Row(
                                children: const [
                                  Icon(Icons.info_outline,size:12,color:Colors.white),
                                  Text('100 % Genuine',style: TextStyle(color: Colors.white,fontSize:12 ),)
                                ],
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.work,size:12,color:Colors.white),
                                  Text('24-7 working days',style: TextStyle(color: Colors.white,fontSize:12 ),)
                                ],
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.production_quantity_limits,size:12,color:Colors.white),
                                  Text('Trusted Products',style: TextStyle(color: Colors.white,fontSize:12 ),)
                                ],
                              ),
                            ],
                          ),

                        ),
                      ],
                    ),
                  ) ,
                ),
                // shape: const RoundedRectangleBorder(
                //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
                // ),
                //flexibleSpace: Image.asset('assets/images/logo.png',fit: BoxFit.cover,),
              ),


            ];
          },
          body: ListView(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
            children: [

              //search widget
              //SearchWidget(),

              const SizedBox(height: 10,),

              //Banner widget
              const SliderBanner(),

              //category
              const SizedBox(height: 10,),




              //category
              const SizedBox(height: 10,),

              //category widget
              Container(
                decoration: BoxDecoration(
                    color: themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100],
                    borderRadius: BorderRadius.circular(8)
                ),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                      child: Row(
                        children: [
                          Image.asset('assets/images/face.gif',height: 30,),
                          const Text('Categories',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                        ],
                      ),
                    ),
                    //const ActionCategory(),
                    const CategoryWidget(),
                  ],
                ),
              ),

              const SizedBox(height: 10,),


              const SizedBox(height: 10,),

              //best Sellers products widget
              Container(
                decoration: BoxDecoration(
                    color:themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100],
                    borderRadius: BorderRadius.circular(8)
                ),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/off.gif',height: 30,),
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text('Best Sellers',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                              ),
                            ],
                          ),
                          InkWell(
                              onTap: (){

                                //view more of the products

                                Navigator.push(context,MaterialPageRoute(builder:(context) => const Latest()));


                              },
                              child: const Text('View More',)
                          )
                        ],
                      ),
                    ),
                    //const ProductsWidget(),
                    const ProWid(),
                  ],
                ),
              ),

              const SizedBox(height: 10,),

              //Featured
              Container(
                decoration: BoxDecoration(
                    color:themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100],
                    borderRadius: BorderRadius.circular(8)
                ),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/off.gif',height: 30,),
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text('Featured',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                              ),
                            ],
                          ),
                          InkWell(
                              onTap: (){

                                //view more of the products

                                Navigator.push(context,MaterialPageRoute(builder:(context) => const MoreFeatured()));


                              },
                              child: const Text('View More',)
                          )
                        ],
                      ),
                    ),
                    //const ProductsWidget(),
                    const Featured(),
                  ],
                ),
              ),

              const SizedBox(height: 10,),


              //Client widget
              Container(
                decoration: BoxDecoration(
                    color: themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100],
                    borderRadius: BorderRadius.circular(8)
                ),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                      child: Row(
                        children: [
                          Image.asset('assets/images/face.gif',height: 30,),
                          const Text('Our Clients',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                        ],
                      ),
                    ),
                    //const ActionCategory(),
                    const ClientSlider(),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }









}



class SearchAds extends SearchDelegate<String>{

  List<dynamic> list;
  SearchAds({required this.list});

  showAllProducts() async{

    var response = await http.post(
        Uri.parse(BaseUrl.searchPro),
        body: {
          "search":encryp(query),
        });
    if(response.statusCode ==200){
      var jsonData=json.decode(response.body);
      return jsonData;

    }

  }


  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      IconButton(
        onPressed:(){
          query="";
          showSuggestions(context);

        },
        icon:const Icon(Icons.close),
      )

    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {

    return IconButton(onPressed:(){
      close(context,"");
    },icon:const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final themeProvider = Provider.of<ThemePro>(context);
    final _formated= NumberFormat();

    return Container(
      color:themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100],
      child:Padding(
        padding:const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
        child:FutureBuilder<dynamic>(
            future: showAllProducts(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:2,
                      childAspectRatio: 1/1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                    ),
                    itemCount:snapshot.data.length,
                    itemBuilder:(context,index){
                      var list=snapshot.data[index];

                      var s_price=int.parse(list['psale_price']);
                      String sprice=_formated.format(s_price);

                      return InkWell(
                        onTap: (){

                          Navigator.push(context,MaterialPageRoute(builder:(context) => ProductDetails(
                            id:list['pid'],nem:list['pname'],regp:list['pregular_price'],selp:list['psale_price'],catid:list['category_id'],disr:list['pdiscount_rate'],ratin:list['prating'],
                            im1:list['pimage1'],im2:list['pimage2'],im3:list['pimage3'],manid:list['manufacturer_id'],storeid:list['store_id'],ava:list['pavailability'],desc:list['pdescription'],
                            promoid:list['promotion_id'], create:list['pdate_created'],subid:list['subcategory_id'],modoid:list['model_id'],fe:list['featured'],retun:list['return_policy'],
                            psdec:list['psdescription'],end:list['end'],
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
                                imageUrl:'https://${BaseUrl.imUrl}${list['pimage1']}',
                                //imageUrl:'https://holomboko.000webhostapp.com/api/assets/images/products/${list['pimage1']}',
                                //imageUrl:'https://www.etl.co.ug/assets/images/products/${list['pimage1']}',
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),


                              Positioned(
                                bottom: 43,
                                left:2,
                                child:  Text(sprice,maxLines:2,overflow:TextOverflow.ellipsis,textAlign: TextAlign.start,style: TextStyle(color:themeProvider.isDarkMode ? Colors.grey.shade900:Colors.black,fontSize: 17,fontWeight: FontWeight.bold
                                ),),
                              ),

                              Positioned(
                                bottom: 2,
                                left: 2,
                                right: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2.0,bottom: 2,top: 4),
                                  child: Text(list['pname'],maxLines:2,overflow:TextOverflow.ellipsis,textAlign: TextAlign.start,style: const TextStyle(fontSize:12),),
                                ),
                              ),

                            ],
                          ),
                        ),
                      );



                    }
                );
              }else{
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
              }

            }),


      ),
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final themeProvider = Provider.of<ThemePro>(context);
    var listData=query.isEmpty ? list:list.where((element) => element.toLowerCase().contains(query)).toList();

    return Container(
      color:themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100] ,
      child:listData.isEmpty ? const Center(child: Text('No Products Found'),):ListView.builder(
          itemCount: listData.length,
          itemBuilder:(context,index){
            return  ListTile(
              onTap: (){
                query=listData[index];
                showResults(context);
              },
              title:Text(listData[index]),
            );
          }
      ) ,
    );
  }

}
