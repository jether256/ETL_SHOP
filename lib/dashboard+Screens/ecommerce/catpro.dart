
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../login-signup/login.dart';
import '../../providers/categoryproductprovider.dart';
import '../../providers/catprovider.dart';
import '../../providers/shopcartprovider.dart';
import '../../theme/theme.dart';
import '../../theme/themenotifier.dart';
import 'cartwidget/allproducts.dart';
import 'cartwidget/cartdialog.dart';
import 'cartwidget/cartproonly.dart';
import 'cartwidget/catdetail.dart';


class CategoriesPro extends StatefulWidget {
  const CategoriesPro({Key? key}) : super(key: key);

  @override
  State<CategoriesPro> createState() => _CategoriesProState();
}

class _CategoriesProState extends State<CategoriesPro> {


  final _formated= NumberFormat();

  bool isLoggedIn=false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _checkLoginStatus();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Provider.of<CategoriesProvider>(context,listen: false);
      Provider.of<CategoryProductProvider>(context,listen: false);
      Provider.of<ShoppingCartProvider>(context,listen: false).getCartCount();
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







  List<String> options=['All products','Toner Catridges','Drum Units','Maintenance Kits','Fuser Units','Rollers',

  ];


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


  String _title='Categories';
  String? selctedCat;

  String? selctID;





  @override
  Widget build(BuildContext context) {


    final themeProvider = Provider.of<ThemePro>(context);

    return Consumer<CategoriesProvider>(
      builder: (context,value,child){


        final cats=value.categs;

        int tag=0;


        return Scaffold(
          appBar: AppBar(
            backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade700:mainColor,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            title:Text(selctedCat == null ? _title:selctedCat!,maxLines: 1,overflow:TextOverflow.ellipsis,style: const TextStyle(color: Colors.white)),
            actions: [
              Consumer<ShoppingCartProvider>(
                  builder: (context,value,child){

                    final count=value.count;

                    return Padding(
                      padding:const EdgeInsets.only(top: 15,right: 15),
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
          body:Column(
            children: [

              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode ? Colors.grey.shade400: Colors.grey[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child:Consumer<CategoriesProvider>(
                  builder: (context,value,child){

                    final cats=value.categs;

                    if(value.isLoading){

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {

                          return  Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 5),
                            child: Container(
                              width: 120,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),

                                  color:themeProvider.isDarkMode ? Colors.grey.shade500: Colors.grey.shade300
                              ),
                              child:Image.asset('assets/images/hug.gif',height:20,width: 90,) ,
                            ),
                          );


                        },);
                    }
                    else if(value.noNet){

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {

                          return  Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 5),
                            child: Container(
                              width: 120,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),

                                  color:themeProvider.isDarkMode ? Colors.grey.shade500: Colors.grey.shade300
                              ),
                              child:Image.asset('assets/images/lost2.gif',height:20,width: 90,fit: BoxFit.cover,) ,
                            ),
                          );


                        },);

                    }

                    return  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:cats.length,
                      itemBuilder: (BuildContext context, int index) {

                        return  Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 5),
                          child: Container(
                            // width: 120,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),

                                  color:themeProvider.isDarkMode ? Colors.grey.shade400:Colors.white10
                              ),
                              child:Consumer<CategoryProductProvider>(
                                builder: (context,value,child){

                                  return ActionChip(
                                    label:Text(cats[index].nem,maxLines: 2,selectionColor:Colors.deepOrangeAccent,),
                                    onPressed:(){


                                      setState(() {
                                        _title=cats[index].nem;
                                        selctedCat=cats[index].nem;
                                        selctID=cats[index].id;
                                      });

                                      //route to product details page with its elements
                                      // Navigator.push(context,MaterialPageRoute(builder:(context) => CategoryMore(
                                      //   id:cats[index].id,nem:cats[index].nem,
                                      // )));
                                      value.getAllCategoryProducts(selctID!);
                                      //EasyLoading.showSuccess('Category clicked');
                                    },
                                  );

                                   }),

                          ),
                        );


                      },);

                  },
                ),
              ),


              selctID== null ? const Expanded(
                child:ProductOnly(),
              ):Expanded(
                child:Catdetail(),
              ),




              // Container(
              //   height: 56,
              //   color: Colors.teal.withOpacity(0.9),
              //   child:ChipsChoice<int>.single(
              //     choiceStyle: const C2ChipStyle(
              //       borderRadius: BorderRadius.all(Radius.circular(25)),
              //     ),
              //     choiceCheckmark: true,
              //     value: tag,
              //     onChanged: (val) => setState(() => tag = val),
              //     choiceItems: C2Choice.listFrom<int, String>(
              //       source: options,
              //       value: (i, v) => i,
              //       label: (i, v) => v,
              //     ),
              //   ),
              // ),
            ],
          ),
        );

      },
    );
  }
}
