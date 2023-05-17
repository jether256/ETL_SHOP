
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../api/url.dart';
import '../../../login-signup/login.dart';
import '../../../providers/favoritepro.dart';
import '../../../providers/shopcartprovider.dart';
import '../../../theme/theme.dart';
import '../../../theme/themenotifier.dart';
import '../cartwidget/cartdialog.dart';

class ProductDetails extends StatefulWidget {
  final String id;
  final String nem;
  final String regp;
  final String selp;
  final String catid;
  final String disr;
  final String ratin;
  final String im1;
  final String im2;
  final String im3;
  final String manid;
  final String storeid;
  final String ava;
  final String desc;
  final String promoid;
  final String create;
  final String subid;
  final String modoid;
  final String fe;
  final String retun;
  final String psdec;
  final String end;

  ProductDetails({super.key, required this.id, required this.nem, required this.regp, required this.selp, required this.catid, required this.disr, required this.ratin, required this.im1, required this.im2, required this.im3, required this.manid, required this.storeid, required this.ava, required this.desc, required this.promoid, required this.create, required this.subid, required this.modoid, required this.fe, required this.retun, required this.psdec, required this.end});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  PageController productImageSlider = PageController();

  final _formated= NumberFormat();

  int _qty=1;


  bool isLoggedIn=false;

  @override
  void initState() {


    super.initState();

    _checkLoginStatus();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Provider.of<ShoppingCartProvider>(context,listen: false).getCartCount();
      Provider.of<ShoppingCartProvider>(context,listen: false);
      Provider.of<FavouriteProvider>(context,listen: false);
    });

  }

  late List photos=[
   // 'https://www.etl.co.ug/assets/images/products/${widget.im1}',
    //'https://www.etl.co.ug/assets/images/products/${widget.im2}',
    //'https://www.etl.co.ug/assets/images/products/${widget.im3}',

    //
    'https://${BaseUrl.imUrl}${widget.im1}',
    'https://${BaseUrl.imUrl}${widget.im2}',
    'https://${BaseUrl.imUrl}${widget.im3}',

    // 'https://holomboko.000webhostapp.com/api/assets/images/products/${widget.im1}',
    // 'https://holomboko.000webhostapp.com/api/assets/images/products/${widget.im2}',
    // 'https://holomboko.000webhostapp.com/api/assets/images/products/${widget.im3}',
  ];


  _checkLoginStatus() async {
    SharedPreferences localStorage= await SharedPreferences.getInstance();
    var Id=localStorage.getString('cust_id');

    if(Id != null){

      setState(() {
        isLoggedIn=true;
      });

    }

  }


  //
  //
  // String? userID;
  // getPref() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //
  //   setState(() {
  //     userID = sharedPreferences.getString(PrefInfo.id);
  //   });
  //
  // }


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

    //var offer=(double.parse(widget.Comp) - double.parse(widget.Price)) /double.parse(widget.Comp) * 100;


    var s_price=int.parse(widget.selp);
    String sprice=_formated.format(s_price);

    var r_price=int.parse(widget.regp);
    String rprice=_formated.format(r_price);


    final themeProvider = Provider.of<ThemePro>(context);

    return Scaffold(
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration:   BoxDecoration(
              color:themeProvider.isDarkMode ? Colors.grey.shade700:mainColor,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title:Text(widget.nem,maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(color: Colors.white)),
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
      ),
      body:ListView(
        shrinkWrap: true,
        padding:const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 60),
        children: [

          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade200,
            ),

            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // product image
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  color: Colors.white,
                  child: PageView(
                    physics: const BouncingScrollPhysics(),
                    controller: productImageSlider,
                    children: List.generate(
                      photos.length,
                          (index) => ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover, imageUrl: photos[index],
                        ),
                      ),
                    ),
                  ),
                ),
                // appbar
                // indicator
                Positioned(
                  bottom: 16,
                  child: SmoothPageIndicator(
                    controller: productImageSlider,
                    count: photos.length,
                    effect: ExpandingDotsEffect(
                      dotColor: mainColor.withOpacity(0.2),
                      activeDotColor: mainColor.withOpacity(0.2),
                      dotHeight: 8,
                    ),
                  ),
                ),
              ],
            ),),

          const SizedBox(
            height: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text(widget.nem,maxLines: 2,overflow:TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
              Container(
                decoration: BoxDecoration(
                    color:themeProvider.isDarkMode ? Colors.grey.shade500:Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(4)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.star,size: 20,color: Colors.orange,),
                      const SizedBox(width: 5,),
                      Text(widget.ratin.toString(),style: const TextStyle(fontSize: 16,color: Colors.white),),
                    ],
                  ),
                ),

              ),

            ],
          ),

          const SizedBox(
            height: 10,
          ),

          Divider(height: 3, thickness: 3,color: Colors.grey.shade300,),

          const SizedBox(height: 10,),

          ///price,description,model ,manufacturer,etc
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:themeProvider.isDarkMode ? Colors.grey.shade500:Colors.grey.shade300,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8,bottom: 3,top: 8),
                  child: Row(
                    children: [
                      const Text('Sell Price:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                      const SizedBox(width: 4,),
                      Text('Shs $sprice',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                    ],
                  ),
                ),

                //regular price
                Padding(
                  padding: const EdgeInsets.only(left: 8,bottom: 3,),
                  child: Row(
                    children: [
                      const Text('Regular Price:',style: TextStyle(fontSize: 16),),
                      const SizedBox(width: 4,),
                      Text('Shs $rprice',style: const TextStyle(fontSize: 16,decoration: TextDecoration.lineThrough),),
                    ],
                  ),
                ),

                //manufacturer
                Padding(
                  padding: const EdgeInsets.only(left: 8,bottom: 3,),
                  child: Row(
                    children: [
                      const Text('Manufacturer:',style: TextStyle(fontSize: 16),),
                      const SizedBox(width: 4,),
                      if(widget.manid=="2")
                        const Text("Toshiba",style: TextStyle(fontSize: 16),),

                      if(widget.manid=="3")
                        const Text("Canon",style: TextStyle(fontSize: 16),),

                      if(widget.manid=="4")
                        const Text("Hp",style: TextStyle(fontSize: 16),),

                      if(widget.manid=="5")
                        const Text("Kyocera",style: TextStyle(fontSize: 16),),


                    ],
                  ),
                ),

                //model
                Padding(
                  padding: const EdgeInsets.only(left: 8,bottom: 3,),
                  child: Row(
                    children: [
                      const Text('Model:',style: TextStyle(fontSize: 16),),
                      const SizedBox(width: 4,),
                      Text(widget.modoid,style: const TextStyle(fontSize: 16,),),
                    ],
                  ),
                ),

                //availability
                Padding(
                  padding: const EdgeInsets.only(left: 8,bottom: 3,),
                  child: Row(
                    children: [
                      const Text('Availability:',style: TextStyle(fontSize: 16),),
                      const SizedBox(width: 4,),
                      Text(widget.ava=="1"? "In Stock":"Out of Stock",style: const TextStyle(fontSize: 16),),
                    ],
                  ),
                ),

              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Divider(height: 3, thickness: 3,color: Colors.grey.shade200,),

          const SizedBox(height: 10,),

          const Text('Description',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),

          const SizedBox(height: 10,),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:themeProvider.isDarkMode ? Colors.grey.shade500:Colors.grey.shade300,
            ),

            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.psdec,style: const TextStyle(fontSize: 16),),
            ),

          ),

          const SizedBox(
            height: 10,
          ),

          Divider(height: 3, thickness: 3,color: Colors.grey.shade200,),

          const SizedBox(height: 20,),

          // Container(
          //   height: 36,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //
          //
          //
          //       FittedBox(
          //         child: Row(
          //           children: [
          //
          //
          //             InkWell(
          //               onTap: (){
          //
          //                 if(_qty>1){
          //
          //                   setState(() {
          //                     _qty--;
          //                   });
          //                 }
          //
          //               },
          //               child: Container(
          //                 decoration: BoxDecoration(
          //                   border: Border.all(color:themeProvider.isDarkMode ? Colors.white: Colors.red,width: 2),
          //                   borderRadius: BorderRadius.circular(4),
          //                 ),
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: Icon(Icons.remove,color:themeProvider.isDarkMode ? Colors.white: Colors.red,),
          //                 ),
          //               ),
          //             ),
          //
          //             Container(
          //               child:  Padding(
          //                 padding: const EdgeInsets.only(left: 20.0,right: 20,top: 8,bottom: 8),
          //                 child:Text(_qty.toString(),style: TextStyle(color:themeProvider.isDarkMode ? Colors.white:Colors.red,fontWeight: FontWeight.bold),),
          //               ),
          //             ),
          //
          //             //increase price on tap
          //             InkWell(
          //               onTap: (){
          //
          //                 setState(() {
          //                   _qty++;
          //                 });
          //
          //               },
          //               child: Container(
          //                 decoration: BoxDecoration(
          //                   border: Border.all(color:themeProvider.isDarkMode ? Colors.white: Colors.green,width: 2),
          //                   borderRadius: BorderRadius.circular(4),
          //                 ),
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: Icon(Icons.add,color:themeProvider.isDarkMode ? Colors.white: Colors.green,),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //
          //
          //
          //       FittedBox(
          //         child: Text('Shs $sprice',style: const TextStyle(fontSize: 16),),
          //       ),
          //     ],
          //   ),
          // ),
          //
          //
          // const SizedBox(height: 40,),

          //add to cart and whishlist


        ],
      ),
      bottomNavigationBar:Container(
        decoration: BoxDecoration(
          color:themeProvider.isDarkMode ? Colors.grey.shade700:Colors.grey[100],
        ),
        child: Row(
          children: [
            // add to cart


            Consumer<ShoppingCartProvider>(
                builder: (context, shop, child) {

                  return Expanded(
                    child:InkWell(
                      onTap: ()
                      async {



                        isLoggedIn == false ? please():shop.CartAdd(id:widget.id, selp:widget.selp,regp:widget.regp,promoid:widget.promoid,context:context);

                      },

                      child:Container(
                        height:56 ,
                        decoration: BoxDecoration(
                          color:mainColor,
                        ),
                        child: Center(child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(CupertinoIcons.cart,color: Colors.white,),
                            SizedBox(width: 4,),
                            Text('Cart',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        ),
                      ),
                    ),
                  );
                }),







            //wishlist

        Consumer<FavouriteProvider>(
        builder: (context, fav, child) {

          return Expanded(
            child: InkWell(
              onTap: ()
              async {
                isLoggedIn == false ? please():fav.AddFav(id:widget.id, selp:widget.selp,regp:widget.regp,promoid:widget.promoid,context:context);

                //isLoggedIn == false ? please():EasyLoading.showSuccess('Save Clicked');


              },

              child:Container(
                height:56 ,
                decoration: const BoxDecoration(
                  color:Colors.black54,
                ),
                child: Center(child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(CupertinoIcons.bookmark,color: Colors.white,),
                    SizedBox(width: 4,),
                    Text('Save',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  ],
                ),
                ),
              ),
            ),
          );

        }),



          ],
        ),
      ),
    );
  }
}
