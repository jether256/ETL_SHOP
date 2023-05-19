
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:edge_app/FCM/fcmconfig.dart';
import 'package:edge_app/dashboard+Screens/ecommerce/orders/notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/cola.dart';
import '../providers/shopcartprovider.dart';
import '../theme/theme.dart';
import '../theme/themenotifier.dart';
import 'ecommerce/accountpro.dart';
import 'ecommerce/cartpro.dart';
import 'ecommerce/cartwidget/cartdialog.dart';
import 'ecommerce/catpro.dart';
import 'ecommerce/homepro.dart';

class Dashboard extends StatefulWidget {
  static const  String id='dash-board';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  bool isLoggedIn=false;


  @override
  void initState() {
    super.initState();
_checkLoginStatus();
// requestNotificationPermission();
// fcmconfig(context:context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Provider.of<ShoppingCartProvider>(context,listen: false).getCartCount();

    });

  }


  _checkLoginStatus() async {
SharedPreferences localStorage= await SharedPreferences.getInstance();
var Id=localStorage.getString('cust_id');

if(Id != null){

  setState(() {
    isLoggedIn=true;
    requestNotificationPermission();
    fcmconfig(context:context);
  });
}

  }

  // List pagesnot=[
  //   const HomeProduct(),
  //   const CategoriesPro(),
  //   const CartPro(),
  //   const AccountPro(),
  // ];
  //
  // List pageslogged=[
  //   const HomeProduct(),
  //   const CategoriesPro(),
  //   const CartDialog(),
  //   const AccountPro(),
  // ];
  //
  // int currentIndex=0;
  //
  // void onTap(int index) {
  //   setState(() {
  //     currentIndex = index;
  //   });
  // }
  //
  // final items=<Widget>[
  //   Icon(Icons.home,size: 30,color:whiteColor,),
  //   Icon(Icons.dashboard,size: 30,color:whiteColor,),
  //   Icon(Icons.shopping_cart,size: 30,color:whiteColor,) ,
  //   Icon(Icons.person,size: 30,color: whiteColor),
  // ];
  //


  int _selectedIndex=0;

  static final List<Widget> _widgetOptionsLogged=<Widget>[
    const HomeProduct(),
    const CategoriesPro(),
    const CartDialog(),
    const AccountPro(),
  ];

  static final List<Widget> _widgetOptionsLoggedNot=<Widget>[
    const HomeProduct(),
    const CategoriesPro(),
    const CartPro(),
    const AccountPro(),
  ];


  void _onItemTapped(int index){

    setState(() {
      _selectedIndex=index;
    });
  }





  @override
  Widget build(BuildContext context) {


    final themeProvider = Provider.of<ThemePro>(context);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100],

          bottomNavigationBar:  BottomAppBar(
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(
                      colors: [
                        blueGradient.darkShade,
                        blueGradient.lightShade,
                      ]
                  )
              ),
              child:Row(
                children: [
                  MaterialButton(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          Icon(_selectedIndex== 0 ? Icons.home:Icons.home_outlined,color:_selectedIndex== 0 ? Colors.red.shade700:Colors.white,size: _selectedIndex == 0 ? 30:23)
                        ],
                      ),
                      onPressed:(){



                        _onItemTapped(0);
                      }

                  ),

                  MaterialButton(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          Icon(_selectedIndex== 1 ? Icons.dashboard:Icons.dashboard_outlined,color: _selectedIndex== 1 ? Colors.red.shade700:Colors.white,size: _selectedIndex == 1 ? 30:23,)
                        ],
                      ),
                      onPressed:(){


                        _onItemTapped(1);
                      }

                  ),
                  MaterialButton(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Consumer<ShoppingCartProvider>(
                              builder: (context,value,child)
                              {

                                final count=value.count;

                                return  Badge(
                                  label:count== null ? const Text('0',style: TextStyle(color: Colors.white,fontSize: 10),):Text('$count',style: const TextStyle(color: Colors.white,fontSize: 10),),
                                  child:Icon(_selectedIndex== 2 ?Icons.shopping_cart:Icons.shopping_cart_outlined,color:_selectedIndex== 2 ? Colors.black87:Colors.white,size: _selectedIndex == 2 ? 30:23) ,
                                );

                              }),



                        ],
                      ),
                      onPressed:(){


                        _onItemTapped(2);

                      }

                  ),
                  MaterialButton(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          Icon(_selectedIndex== 3 ?Icons.person:Icons.person_outline_outlined,color:_selectedIndex== 3 ? Colors.red.shade700:Colors.white,size: _selectedIndex == 3 ? 30:23)
                        ],
                      ),
                      onPressed:(){



                        _onItemTapped(3);
                      }

                  ),
                ],
              ) ,
            ),

          ),
          // extendBody: true,
          body:isLoggedIn ? _widgetOptionsLogged[_selectedIndex]:_widgetOptionsLoggedNot[_selectedIndex],
          // bottomNavigationBar:CurvedNavigationBar(
          //   color:themeProvider.isDarkMode ? Colors.grey.shade700:mainColor,
          //   buttonBackgroundColor:themeProvider.isDarkMode ? Colors.grey.shade700:mainColor,
          //   backgroundColor: Colors.transparent,
          //   height: 60,
          //   items:items,
          //   animationCurve: Curves.easeInOut,
          //   animationDuration: const Duration(microseconds: 300),
          //   index:currentIndex,
          //   onTap:onTap,
          // ),
        ),
      onWillPop:() async{

        return false;
      },
    );
  }


}