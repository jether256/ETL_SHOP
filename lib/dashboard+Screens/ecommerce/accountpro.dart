import 'package:edge_app/dashboard+Screens/ecommerce/contactus/contactus.dart';
import 'package:edge_app/dashboard+Screens/ecommerce/orders/my_orders.dart';
import 'package:edge_app/dashboard+Screens/ecommerce/shippingdetails/shipping.dart';
import 'package:edge_app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../login-signup/login.dart';
import '../../providers/my_order_pro.dart';
import '../../providers/shopcartprovider.dart';
import '../../theme/theme.dart';
import '../../theme/themenotifier.dart';
import '../dashboard.dart';
import 'cartwidget/cartdialog.dart';
import 'creditcards/create-new_screen.dart';
import 'creditcards/creditcard.dart';
import 'favorites/favorite.dart';
import 'orders/notifications.dart';

class AccountPro extends StatefulWidget {
  const AccountPro({Key? key}) : super(key: key);

  @override
  State<AccountPro> createState() => _AccountProState();
}

class _AccountProState extends State<AccountPro> {

  bool? _darkMode=false;
  bool isLoggedIn=false;

  @override
  void initState() {

    _checkLoginStatus();

    setState(() {
      _darkMode=darkMode;
    });

    getPref();


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Provider.of<ShoppingCartProvider>(context,listen: false).getCartCount();
      Provider.of<MyOrdersProviders>(context,listen: false).getOrderNotiCount();
    });

    super.initState();
  }

  String? fnem,lnem;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {

      fnem= sharedPreferences.getString("cust_fname");
      lnem= sharedPreferences.getString("cust_lname");


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


    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade700:mainColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title:const Text('Account',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100],
      body: ListView(
        padding: const EdgeInsets.only(left: 10,right: 10,top:10,bottom: 60),
        children:  [

          Container(
            decoration: BoxDecoration(
              color:themeProvider.isDarkMode ? Colors.grey.shade500: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child:  ListTile(
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/favi.png'),
              ),
              title: Text(isLoggedIn ?'${fnem} ${lnem}':'Profile',style: const TextStyle(fontSize: 20),),
              subtitle: const Text('Profile'),
            ),
          ),
          const SizedBox(height: 5),
          const Divider(height: 5,thickness: 5,),

            const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? Colors.grey.shade500: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                //profile
                ListTile(
                  onTap: (){



                  },
                  leading: Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person,color: Colors.blue,size: 35,),
                  ),
                  title: Text(isLoggedIn ?'${fnem} ${lnem}':'Account',style: TextStyle(fontSize: 18),),
                  trailing:const Icon(Icons.arrow_forward_ios_outlined),

                ),

                const SizedBox(height: 10,),

                //notifications
                ListTile(
                  onTap: (){

                    isLoggedIn ?  Navigator.push(context,MaterialPageRoute(builder: (context)=> const NotificationsPage())):please();

                  },
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Consumer<MyOrdersProviders>(
                        builder: (context,value,child){

                          final count=value.count;
                          //
                          return Padding(
                            padding:const EdgeInsets.only(top: 20),
                            child:InkWell(
                              child:Badge(
                                label:count== null ? const Text('0',style: TextStyle(color: Colors.white,fontSize: 10),):Text('$count',style: const TextStyle(color: Colors.white,fontSize: 10),),
                                child:const Icon(Icons.notifications,color:Colors.purple,size: 35,) ,
                              ),
                              onTap: (){

                                ///to notifications page
                                Navigator.push(context,MaterialPageRoute(builder: (context)=> const NotificationsPage()));

                              },
                            ),
                          );

                        }),
                  ),
                  title: const Text('Notifications',style: TextStyle(fontSize: 18),),
                  trailing:const Icon(Icons.arrow_forward_ios_outlined),

                ),

                const SizedBox(height: 10,),


                //manage cards
                ListTile(
                  onTap: (){

                   // isLoggedIn ?  Navigator.push(context,MaterialPageRoute(builder: (context)=> const CreditCard())):please();
                    isLoggedIn ?  Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateCard ())):please();

                  },
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      shape: BoxShape.circle,
                    ),
                    child:const Icon(Icons.credit_card,color:Colors.cyan,size: 35,),
                  ),
                  title: const Text('Credit Cards',style: TextStyle(fontSize: 18),),
                  trailing:const Icon(Icons.arrow_forward_ios_outlined),

                ),

                const SizedBox(height: 10,),

                //cart
                ListTile(
                  onTap: (){

                    isLoggedIn ?  Navigator.push(context,MaterialPageRoute(builder: (context)=> const CartDialog())):please();

                  },
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Consumer<ShoppingCartProvider>(
                        builder: (context,value,child){

                          final count=value.count;
                          //
                          return Padding(
                            padding:const EdgeInsets.only(top: 20),
                            child:InkWell(
                              child:Badge(
                                label:count== null ? const Text('0',style: TextStyle(color: Colors.white,fontSize: 10),):Text('$count',style: const TextStyle(color: Colors.white,fontSize: 10),),
                                child:const Icon(Icons.shopping_cart,color:Colors.green,size: 35,) ,
                              ),
                              onTap: (){

                              },
                            ),
                          );

                        }),
                  ),
                  title: const Text('Cart',style: TextStyle(fontSize: 18),),
                  trailing:const Icon(Icons.arrow_forward_ios_outlined),

                ),

                const SizedBox(height: 10,),

                //orders
                ListTile(
                  onTap: (){


                    isLoggedIn ?  Navigator.push(context, MaterialPageRoute(builder:(context)=>const MyOrders())):please();

                    //EasyLoading.showSuccess('Privacy orders clicked.....');
                  },
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.shop_two,color: Colors.indigo,size: 35,),
                  ),
                  title: const Text('Orders',style: TextStyle(fontSize: 18),),
                  trailing:const Icon(Icons.arrow_forward_ios_outlined),

                ),

                const SizedBox(height: 10,),

                //shipping details
                // ListTile(
                //   onTap: (){
                //
                //
                //
                //     isLoggedIn ? Navigator.push(context, MaterialPageRoute(builder:(context)=>ShippingDetails())):please();
                //
                //
                //   },
                //   leading: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.green.shade100,
                //       shape: BoxShape.circle,
                //     ),
                //     child: const Icon(Icons.directions_boat,color: Colors.green,size: 35,),
                //   ),
                //   title: const Text('Shipping Details',style: TextStyle(fontSize: 18),),
                //   trailing:const Icon(Icons.arrow_forward_ios_outlined),
                //
                // ),
                //
                // const SizedBox(height: 10,),

                //general
                // ListTile(
                //   onTap: (){
                //
                //
                //
                //     isLoggedIn ? Navigator.push(context, MaterialPageRoute(builder:(context)=>const FavoritePage())):please();
                //
                //
                //   },
                //   leading: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.green.shade100,
                //       shape: BoxShape.circle,
                //     ),
                //     child: const Icon(CupertinoIcons.heart_fill,color: Colors.red,size: 35,),
                //   ),
                //   title: const Text('Favorite Products',style: TextStyle(fontSize: 18),),
                //   trailing:const Icon(Icons.arrow_forward_ios_outlined),
                //
                // ),
                //
                // const SizedBox(height: 10,),

                //about us
                ListTile(
                  onTap: (){




                    Navigator.push(context, MaterialPageRoute(builder:(context)=>const ContactusPage()));


                    //EasyLoading.showSuccess('About us clicked.....');

                  },
                  leading: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.mail,color: Colors.orange,size: 35,),
                  ),
                  title: const Text('Contact us',style: TextStyle(fontSize: 18),),
                  trailing:const Icon(Icons.arrow_forward_ios_outlined),

                ),

                const SizedBox(height: 10,),

                //theme
                ListTile(
                  onTap: (){



                   // EasyLoading.showSuccess('Change Theme clicked.....');

                  },
                  leading:Switch.adaptive(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      final provider = Provider.of<ThemePro>(context, listen: false);
                      provider.toggleTheme(value);
                    },
                  ),
                  title: const Text('Themes',style: TextStyle(fontSize: 18),),
                  trailing:const Icon(Icons.arrow_forward_ios_outlined),

                ),
              ],
            ),
          ),



          const Divider(thickness: 5,),

          const SizedBox(height: 3,),


          //logout
          Container(
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? Colors.grey.shade500: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: ListTile(
              onTap: (){

                isLoggedIn ? lougOut():please();

                //EasyLoading.showSuccess('Logout clicked.....');
              },
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.login_outlined,color: Colors.red,size: 35,),
              ),
              title: const Text('Log out',style: TextStyle(fontSize: 18),),
              trailing:const Icon(Icons.arrow_forward_ios_outlined),

            ),
          ),

        ],
      ),
    );
  }


}
