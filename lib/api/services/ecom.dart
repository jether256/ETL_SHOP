import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:edge_app/dashboard+Screens/ecommerce/paymentmethods/paymentmethod.dart';
import 'package:edge_app/login-signup/check%20verificationcode.dart';
import 'package:edge_app/login-signup/login.dart';
import 'package:edge_app/models/notimodel.dart';
import 'package:edge_app/models/odermodel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../dashboard+Screens/dashboard.dart';
import '../../dashboard+Screens/ecommerce/checkout/checkout.dart';
import '../../dashboard+Screens/ecommerce/shippingdetails/shipping.dart';
import '../../encryption/encrypt.dart';
import '../../login-signup/forgotpass.dart';
import '../../login-signup/loginCheck.dart';
import '../../models/cartmodel.dart';
import '../../models/categorymodel.dart';
import '../../models/favmodel.dart';
import '../../models/oderitemmodel.dart';
import '../../models/partnermodel.dart';
import '../../models/productmodel.dart';
import '../url.dart';

// api calls for all http requests
class ApiCall {



  ///get categories
  Future<List<CategoryModel>?> geCat() async {


    var response = await http.get(
        Uri.parse(BaseUrl.category),
        headers: {"Accept": "headers/json"});


    if (response.statusCode == 200) {

      return categoriesFromJson(
          json.decode(response.body)
      );

    } else {

      return null;

    }


  }


  ///get products
  Future<List<ProductModel>?> getPro() async {
    //var response = await http.get(Uri.parse(BaseUrl.category));

    var response = await http.get(
        Uri.parse(BaseUrl.getProduct),
        headers: {"Accept": "headers/json"});

    if (response.statusCode == 200) {
      return productFromJson(
          json.decode(response.body)
      );
    } else {
      return null;
    }



  }



  ///register function
  //register user function

  Future  Register( String email, String password, String firstName, String lastName, String address, String phone, BuildContext context, String country) async {

    var response = await http.post(
      Uri.parse(
          BaseUrl.apiRegister),
      //headers can be left out since CORS doesn't affect apps but it will affect A flutter web app,
      //so just to be safe include them.
      headers: {"Accept": "headers/json"},
      body:{
        "lname": encryp(lastName),
        "fname": encryp(firstName),
        "phone": encryp(phone),
        "count": encryp(country),
        "add": encryp(address),
        "ema": encryp(email),
        "pass": encryp(password),
      },
    );


    if(response.statusCode==200){

      var userData=json.decode(response.body);

           if(context.mounted){// context is needed for the navigator and snackbar to work

             // check if the email already exists else register user
             if(userData=="ERROR"){



               ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     content: const Text("Email already exists"),
                     backgroundColor: Colors.red.withOpacity(0.9),
                     elevation: 10, //shadow
                   )
               );

             }

             else if(userData=="REG"){

               ///verify otp code sent and pass email to Check code page

               Navigator.push(context,MaterialPageRoute(builder:(context)=>CheckCode(mail:email)));
               //Navigator.pushNamed(context,CheckCode.id);

               ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     content: const Text("Verify Phone Number"),
                     backgroundColor: Colors.green.withOpacity(0.9),
                     elevation: 10, //shadow
                   )
               );

               print(userData);
             }


           }

    }else{

      return null;
    }





  }


  ///verify email function
  Future  MailVeri( String email, String code, BuildContext context) async {

    var response = await http.post(
      Uri.parse(
          BaseUrl.regVerify),
      //headers can be left out since CORS doesn't affect apps but it will affect A flutter web app,
      //so just to be safe include them.
      headers: {"Accept": "headers/json"},
      body:{
        "email": encryp(email),
        "key": encryp(code),
      },
    );


    if(response.statusCode==200){

      var userData=json.decode(response.body);

      if(context.mounted){// context is needed for the navigator and snackbar to work

        // check if the email already exists else register user
        if(userData=="ye"){


          ///route to login page after verification
          Navigator.pushNamed(context,Login.id);

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Verification Successfully Login Now"),
                backgroundColor: Colors.green.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );

        }

        else if(userData=="no"){


          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Wrong Code"),
                backgroundColor: Colors.red.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );

        }


      }

    }else{

      return null;
    }





  }

  ///send Mail
  Future  sentMail( String email,BuildContext context) async {

    var response = await http.post(
      Uri.parse(
          BaseUrl.checkMail),
      //headers can be left out since CORS doesn't affect apps but it will affect A flutter web app,
      //so just to be safe include them.
      headers: {"Accept": "headers/json"},
      body:{
        "mail": encryp(email),
      },
    );


    if(response.statusCode==200){

      var userData=json.decode(response.body);

      if(context.mounted){// context is needed for the navigator and snackbar to work

        // check if the email already exists else register user
        if(userData=="Ye"){


          ///route to check email evrification code page after verification

          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginCheckCode(mail:email)));

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Email Sent"),
                backgroundColor: Colors.green.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );

        }

        else if(userData=="Fail"){


          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Failed to send Email"),
                backgroundColor: Colors.red.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );

        }

        else if(userData=="No"){


          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Email doesn't exist"),
                backgroundColor: Colors.red.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );

        }


      }

    }else{

      return null;
    }





  }


  ///verify password function
  Future  PassVeri( String email, String code, BuildContext context) async {

    var response = await http.post(
      Uri.parse(
          BaseUrl.passVerify),
      //headers can be left out since CORS doesn't affect apps but it will affect A flutter web app,
      //so just to be safe include them.
      headers: {"Accept": "headers/json"},
      body:{
        "email": encryp(email),
        "key": encryp(code),
      },
    );


    if(response.statusCode==200){

      var userData=json.decode(response.body);

      if(context.mounted){// context is needed for the navigator and snackbar to work

        // check if the email already exists else register user
        if(userData=="ye"){


          ///route to password reset page after after verification
          //Navigator.pushNamed(context,ForgotPassword.id);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword(mail:email)));

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Verification Successfully Set new Password"),
                backgroundColor: Colors.green.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );

        }

        else if(userData=="no"){


          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Wrong Code"),
                backgroundColor: Colors.red.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );

        }


      }

    }else{

      return null;
    }





  }

  ///login function
  Future<Map<String,dynamic>?> LoginUz(String email,String password ,BuildContext context) async{

   var response = await http.post(
       Uri.parse(BaseUrl.apiLogin),
       headers: {"Accept": "headers/json"},
       body:{
         "ema": encryp(email),
         "pass": encryp(password),
       }
     ,
   );

   if (response.statusCode == 200) {

     var userData = json.decode(response.body);

     //Set json data to string variables

        String ID = userData['cust_id'];
       String fnem = userData['cust_fname'];
       String lnem = userData['cust_lname'];
       String mail = userData['cust_email'];
       String phon = userData['cust_phone'];
       String loc = userData['cust_location'];
       String pic = userData['cust_photo'];
       String pass = userData['cust_password'];
       String con = userData['cust_country'];
       String date = userData['cust_created_on'];

 


     if (userData == "ERROR") {

      if(context.mounted){


        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Wrong Email or Password"),
              backgroundColor: Colors.red.withOpacity(0.9),
              elevation: 10, //shadow
            )
        );

        // final snackBar = SnackBar(
        //   elevation: 0,
        //   behavior: SnackBarBehavior.floating,
        //   backgroundColor: Colors.transparent,
        //   content: AwesomeSnackbarContent(
        //     title: 'Login Failure',
        //     message:
        //     'Failed to login',
        //     contentType: ContentType.failure,
        //   ),
        // );
        //
        // ScaffoldMessenger.of(context)
        //   ..hideCurrentSnackBar()
        //   ..showSnackBar(snackBar);
      }

     }else{


       //Pass string variables into shared prefrences
       SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
       sharedPreferences.setString("cust_id",ID);
       sharedPreferences.setString("cust_fname",fnem);
       sharedPreferences.setString("cust_email", mail);
       sharedPreferences.setString("cust_lname", lnem);
       sharedPreferences.setString("cust_phone", phon);
       sharedPreferences.setString("cust_location",loc);
       sharedPreferences.setString("cust_photo", pic);
       sharedPreferences.setString("cust_password", pass);
       sharedPreferences.setString("cust_country", con);
       sharedPreferences.setString("cust_created_on", date);

       String? UID=sharedPreferences.getString("cust_id");

       FirebaseMessaging.instance.subscribeToTopic("users");
       FirebaseMessaging.instance.subscribeToTopic("users${UID}");

    if(context.mounted){

      Navigator.pushReplacementNamed(context,Dashboard.id);

      //EasyLoading.showSuccess(' Logged in...');


      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Logged In"),
            backgroundColor: Colors.green.withOpacity(0.9),
            elevation: 10, //shadow
          )
      );

      //
      // final snackBar = SnackBar(
      //   elevation: 0,
      //   behavior: SnackBarBehavior.floating,
      //   backgroundColor: Colors.transparent,
      //   content: AwesomeSnackbarContent(
      //     title: 'Logged In',
      //     message:
      //     'Success fully Logged In',
      //     contentType: ContentType.success,
      //   ),
      // );
      //
      // ScaffoldMessenger.of(context)
      //   ..hideCurrentSnackBar()
      //   ..showSnackBar(snackBar);

    }



       print(userData);
     }
   }else{

     return null;
   }



 }


  ///get products by category
  Future<List<ProductModel>?> getCatPro(String id) async {
    //var response = await http.get(Uri.parse(BaseUrl.category));

    var response = await http.post(
        Uri.parse(BaseUrl.getProductCategory),
        headers: {"Accept": "headers/json"},
        body:{'catid':encryp(id)}
    );

    if (response.statusCode == 200) {
      return productFromJson(
          json.decode(response.body)
      );
    } else {
      return null;
    }
  }


  ///get products by subcategory
  Future<List<ProductModel>?> getSubCatPro(String Sbid) async {



    var response = await http.post(
        Uri.parse(BaseUrl.getProductSubCategory),
        headers: {"Accept": "headers/json"},
        body:{'subid':Sbid}
    );

    if (response.statusCode == 200) {
      return productFromJson(
          json.decode(response.body)
      );
    } else {
      return null;
    }
  }

  ///get products by featured
  Future<List<ProductModel>?> getFeatured() async {
    //var response = await http.get(Uri.parse(BaseUrl.category));

    var response = await http.get(
        Uri.parse(BaseUrl.getProductFeatured),
        headers: {"Accept": "headers/json"},
    );

    if (response.statusCode == 200) {
      return productFromJson(
          json.decode(response.body)
      );
    } else {
      return null;
    }
  }



  ///add to cart
  Future<Map<String,dynamic>?> addToCart(String id, String selp, String regp, String promoid, BuildContext context) async {

    SharedPreferences pref= await SharedPreferences.getInstance();
    String? ID=pref.getString('cust_id');


    var response = await http.post(Uri.parse(BaseUrl.addToCart),
        //headers can be left out since CORS doesn't affect apps but it will affect A flutter web app,
        //so just to be safe include them.
        headers: {"Accept": "headers/json"},
        body: {
          "proid": encryp(id),
          "slp": encryp(selp),
          "rp": encryp(regp),
          "quant": encryp("1"),
          "uid": encryp(ID!),
          "promoid": encryp(promoid),
        });


    if (response.statusCode == 200) {
      var userData = json.decode(response.body);


      if (userData == "ye") {

        //EasyLoading.showError('Already in the Cart');


        if(context.mounted){


          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Added to Cart"),
                backgroundColor: Colors.green.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );



        }


      } else if(userData == "ERROR"){

        if(context.mounted){


          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Already in the Cart"),
                backgroundColor: Colors.red.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );

          //
          // final snackBar = SnackBar(
          //   elevation: 0,
          //   behavior: SnackBarBehavior.floating,
          //   backgroundColor: Colors.transparent,
          //   content: AwesomeSnackbarContent(
          //     title: 'Added',
          //     message:
          //     'Added to cart',
          //     contentType: ContentType.success,
          //   ),
          // );
          //
          // ScaffoldMessenger.of(context)
          //   ..hideCurrentSnackBar()
          //   ..showSnackBar(snackBar);

        }


        // EasyLoading.showSuccess('Added to cart');

      }
      print(userData);
    }


  }



  ///get Cart products
  Future<List<CartModel>?> getCart() async {

    SharedPreferences pref= await SharedPreferences.getInstance();
    String? ID=pref.getString('cust_id');

    var response = await http.post(
        Uri.parse(BaseUrl.getCarttt),
        headers: {"Accept": "headers/json"},
        body:{'id':encryp(ID!)}
    );

    if (response.statusCode == 200) {
      return cartsFromJson(
          json.decode(response.body)
      );
    } else {
      return null;
    }
  }



  ///update quantity cart
  Future<Map<String,dynamic>?> updateQaunt(String catid, String quant, BuildContext context) async {

    var response = await http.post(Uri.parse(BaseUrl.updateCart),
        //headers can be left out since CORS doesn't affect apps but it will affect A flutter web app,
        //so just to be safe include them.
        headers: {"Accept": "headers/json"},
        body: {
          "catid": encryp(catid),
          "quant": encryp(quant),
        });


    if (response.statusCode == 200) {
      var userData = json.decode(response.body);

      // if (userData == "0") {
      //
      //
      //
      //
      //   if(context.mounted){
      //
      //
      //     final snackBar = SnackBar(
      //       elevation: 0,
      //       behavior: SnackBarBehavior.floating,
      //       backgroundColor: Colors.transparent,
      //       content: AwesomeSnackbarContent(
      //         title: 'Failed',
      //         message:
      //         'Failed to update',
      //         contentType: ContentType.warning,
      //       ),
      //     );
      //
      //     ScaffoldMessenger.of(context)
      //       ..hideCurrentSnackBar()
      //       ..showSnackBar(snackBar);
      //
      //   }
      //
      //
      // } else {
      //
      //   if(context.mounted){
      //
      //
      //     final snackBar = SnackBar(
      //       elevation: 0,
      //       behavior: SnackBarBehavior.floating,
      //       backgroundColor: Colors.transparent,
      //       content: AwesomeSnackbarContent(
      //         title: 'Added',
      //         message:
      //         'Added to cart',
      //         contentType: ContentType.success,
      //       ),
      //     );
      //
      //     ScaffoldMessenger.of(context)
      //       ..hideCurrentSnackBar()
      //       ..showSnackBar(snackBar);
      //
      //   }
      //
      //
      //   // EasyLoading.showSuccess('Added to cart');
      //
      // }
      print(userData);
    }


  }


  ///delete from cart
  Future<Map<String,dynamic>?> delCart(String catid,BuildContext context) async {

    var response = await http.post(Uri.parse(BaseUrl.deleteCart),
        //headers can be left out since CORS doesn't affect apps but it will affect A flutter web app,
        //so just to be safe include them.
        headers: {"Accept": "headers/json"},
        body: {
          "catid": encryp(catid),
        });


    if (response.statusCode == 200) {

     if(context.mounted){

       // ScaffoldMessenger.of(context).showSnackBar(
       //     SnackBar(
       //       content: const Text("Deleted"),
       //       backgroundColor: Colors.red.withOpacity(0.9),
       //       elevation: 10, //shadow
       //     )
       // );

       // final snackBar = SnackBar(
       //   elevation: 0,
       //   behavior: SnackBarBehavior.floating,
       //   backgroundColor: Colors.transparent,
       //   content: AwesomeSnackbarContent(
       //     title: 'Deleted',
       //     message:
       //     'Deleted',
       //     contentType: ContentType.success,
       //   ),
       // );
       //
       // ScaffoldMessenger.of(context)
       //   ..hideCurrentSnackBar()
       //   ..showSnackBar(snackBar);
     }


    }


  }




  ///get Total Price
  Future getCartTotal() async {

    SharedPreferences pref= await SharedPreferences.getInstance();
    String? ID=pref.getString('cust_id');

    var response = await http.post(
        Uri.parse(BaseUrl.getTotalPrice),
        headers: {"Accept": "headers/json"},
        body:{'uid':encryp(ID!)}
    );

    if (response.statusCode == 200) {
      final data= jsonDecode(response.body);

     return int.parse(data);

    } else {

      return null;
    }

  }


  ///get cart Count
  Future getCount() async {

    SharedPreferences pref= await SharedPreferences.getInstance();
    String? ID=pref.getString('cust_id');

    var response = await http.post(
        Uri.parse(BaseUrl.cartCount),
        headers: {"Accept": "headers/json"},
        body:{'uid':encryp(ID!)}
    );

    if (response.statusCode == 200) {
      final data= jsonDecode(response.body);

      return data;


    } else {

      return null;
    }

  }


  ///check whether shipping address exists
  Future checkShip(BuildContext context) async{

    SharedPreferences pref= await SharedPreferences.getInstance();
    String? ID=pref.getString('cust_id');

    var response = await http.post(
      Uri.parse(
          BaseUrl.shipCheck),
      //headers can be left out since CORS doesn't affect apps but it will affect A flutter web app,
      //so just to be safe include them.
      headers: {"Accept": "headers/json"},
      body:{
        "uid": encryp(ID!),
      },
    );


    if(response.statusCode==200){

      var userData=json.decode(response.body);

      if(context.mounted){// context is needed for the navigator and snackbar to work

        // check if the email already exists else register user
        if(userData=="DONE"){


          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Order Placed Successfully"),
                backgroundColor: Colors.red.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );
          Navigator.push(context,MaterialPageRoute(builder:(context)=>Checkout()));




        }else {

          //Navigator.pushNamed(context, Login.id);




          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Expanded(
                child: AlertDialog(
                  //backgroundColor:themeProvider.isDarkMode ? Colors.grey.shade500 :Colors.grey.shade300,
                  title: const Text('Welcome'),
                  content: const Text('Please first save your shipping details'),
                  actions: [
                    MaterialButton(
                      color: Colors.blue,
                      //hoverColor: Colors.green,
                      textColor: Colors.white,
                      onPressed: () {

                        Navigator.pushNamed(context, ShippingDetails.id);

                        //Navigator.push(context, MaterialPageRoute(builder:(context)=>ShippingDetails()));


                      },
                      child: const Text('Save Details'),
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


          //
          //
          //
          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: const Text("Failed to make order"),
          //       backgroundColor: Colors.green.withOpacity(0.9),
          //       elevation: 10, //shadow
          //     )
          // );



          print(userData);
        }


      }

    }else{

      return null;
    }


  }

  ///shipping function function
  Future  saveShip(String firstName, String lastName, String email, String address, String phone, String country, BuildContext context ) async {

    SharedPreferences pref= await SharedPreferences.getInstance();
    String? ID=pref.getString('cust_id');

    var response = await http.post(
      Uri.parse(
          BaseUrl.shipping),
      //headers can be left out since CORS doesn't affect apps but it will affect A flutter web app,
      //so just to be safe include them.
      headers: {"Accept": "headers/json"},
      body:{
        "uid": encryp(ID!),
        "lname": encryp(firstName),
        "fname": encryp(lastName),
        "phone": encryp(phone),
        "count": encryp(country),
        "add": encryp(address),
        "ema": encryp(email),
      },
    );


    if(response.statusCode==200){

      var userData=json.decode(response.body);

      if(context.mounted){// context is needed for the navigator and snackbar to work

        // check if the email already exists else register user
        if(userData=="up"){


          // Check(context);


          Navigator.pushNamed(context, PaymentMethod.id);

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Details updated"),
                backgroundColor: Colors.green.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );




        }

        if(userData=="add"){



          //Check(context);

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Shipping details added successfully"),
                backgroundColor: Colors.green.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );

          /// route to payment method
          Navigator.pushNamed(context, PaymentMethod.id);

          ///Navigator.push(context, MaterialPageRoute(builder:(context)=>Checkout()));

          print(userData);
        }


      }

    }else{

      return null;
    }





  }




  ///checkout function function
  Future  Check(BuildContext context, String method ) async {

    SharedPreferences pref= await SharedPreferences.getInstance();
    String? ID=pref.getString('cust_id');

    var response = await http.post(
      Uri.parse(
          BaseUrl.checkOut),
      //headers can be left out since CORS doesn't affect apps but it will affect A flutter web app,
      //so just to be safe include them.
      headers: {"Accept": "headers/json"},
      body:{
        "uid": encryp(ID!),
        "mtd": encryp(method),
      },
    );


    print('checkout hit');

    if(response.statusCode==200){

      var userData=json.decode(response.body);


      if(context.mounted){// context is needed for the navigator and snackbar to work

        // check if the shipping details exist then checkout
        if(userData=="done"){


          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Order Placed Successfully"),
                backgroundColor: Colors.green.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );

          Navigator.pushNamed(context, Checkout.id);


          //Navigator.push(context,MaterialPageRoute(builder:(context)=>Checkout()));




        }else {

          // showDialog(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return Expanded(
          //       child: AlertDialog(
          //         //backgroundColor:themeProvider.isDarkMode ? Colors.grey.shade500 :Colors.grey.shade300,
          //         title: const Text('Welcome'),
          //         content: const Text('Please first save your shipping details'),
          //         actions: [
          //           MaterialButton(
          //             color: Colors.blue,
          //             //hoverColor: Colors.green,
          //             textColor: Colors.white,
          //             onPressed: () {
          //
          //               Navigator.pushNamed(context, ShippingDetails.id);
          //
          //               //Navigator.push(context, MaterialPageRoute(builder:(context)=>ShippingDetails()));
          //
          //
          //             },
          //             child: const Text('Save Details'),
          //           ),
          //           MaterialButton(
          //             color: Colors.red,
          //             textColor: Colors.white,
          //             onPressed: () {
          //
          //               Navigator.pop(context);
          //             },
          //             child: Text('Cancel'),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // );
          //


          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Failed to make order"),
                backgroundColor: Colors.green.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );

          print(userData);
        }


      }

    }else{

      return null;
    }





  }




  ///get my orders
  Future<List<OrderModel>?> getOder() async {

    SharedPreferences pref= await SharedPreferences.getInstance();
    String? ID=pref.getString('cust_id');

    var response = await http.post(
        Uri.parse(BaseUrl.myOd),
        headers: {"Accept": "headers/json"},
        body:{'id':encryp(ID!)}
    );

    if (response.statusCode == 200) {
      return orderFromJson(
          json.decode(response.body)
      );
    } else {
      return null;
    }
  }


  ///get my orders details
  Future<List<OrderItemsModel>?> getOderDetails( String id) async {
    //
    // SharedPreferences pref= await SharedPreferences.getInstance();
    // String? ID=pref.getString('cust_id');

    var response = await http.post(
        Uri.parse(BaseUrl.myOdDetails),
        headers: {"Accept": "headers/json"},
        body:{
          'trans':encryp(id),
        }
    );

    if (response.statusCode == 200) {
      return oderitemsFromJson(
          json.decode(response.body)
      );
    } else {
      return null;
    }
  }








  ///add to favourite
  Future<Map<String,dynamic>?> addToFav(String id, String selp, String regp, String promoid, BuildContext context) async {

    SharedPreferences pref= await SharedPreferences.getInstance();
    String? ID=pref.getString('cust_id');


    var response = await http.post(Uri.parse(BaseUrl.addFav),
        //headers can be left out since CORS doesn't affect apps but it will affect A flutter web app,
        //so just to be safe include them.
        headers: {"Accept": "headers/json"},
        body: {
          "proid": encryp(id),
          "slp": encryp(selp),
          "rp": encryp(regp),
          "quant": encryp("1"),
          "uid": encryp(ID!),
          "promoid": encryp(promoid),
        });


    if (response.statusCode == 200) {
      var userData = json.decode(response.body);


      if (userData == "ERROR") {

        //EasyLoading.showError('Already in the Cart');


        if(context.mounted){


          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Already in Favorite"),
                backgroundColor: Colors.red.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );


        }


      } else if(userData == "ye"){

        if(context.mounted){


          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Added to favourite"),
                backgroundColor: Colors.green.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );

          //
          // final snackBar = SnackBar(
          //   elevation: 0,
          //   behavior: SnackBarBehavior.floating,
          //   backgroundColor: Colors.transparent,
          //   content: AwesomeSnackbarContent(
          //     title: 'Added',
          //     message:
          //     'Added to cart',
          //     contentType: ContentType.success,
          //   ),
          // );
          //
          // ScaffoldMessenger.of(context)
          //   ..hideCurrentSnackBar()
          //   ..showSnackBar(snackBar);

        }


        // EasyLoading.showSuccess('Added to cart');

      }
      print(userData);
    }


  }


  ///get favorite products
  Future<List<FavoriteModel>?> getFav() async {

    SharedPreferences pref= await SharedPreferences.getInstance();
    String? ID=pref.getString('cust_id');

    var response = await http.post(
        Uri.parse(BaseUrl.getFav),
        headers: {"Accept": "headers/json"},
        body:{'id':encryp(ID!)}
    );

    if (response.statusCode == 200) {
      return favFromJson(
          json.decode(response.body)
      );
    } else {
      return null;
    }
  }



  ///delete from favorite
  Future<Map<String,dynamic>?> delFav(String catid,BuildContext context) async {

    var response = await http.post(Uri.parse(BaseUrl.delFav),
        //headers can be left out since CORS doesn't affect apps but it will affect A flutter web app,
        //so just to be safe include them.
        headers: {"Accept": "headers/json"},
        body: {
          "id": encryp(catid),
        });


    if (response.statusCode == 200) {

      if(context.mounted){

        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: const Text("Deleted"),
        //       backgroundColor: Colors.red.withOpacity(0.9),
        //       elevation: 10, //shadow
        //     )
        // );

        // final snackBar = SnackBar(
        //   elevation: 0,
        //   behavior: SnackBarBehavior.floating,
        //   backgroundColor: Colors.transparent,
        //   content: AwesomeSnackbarContent(
        //     title: 'Deleted',
        //     message:
        //     'Deleted',
        //     contentType: ContentType.success,
        //   ),
        // );
        //
        // ScaffoldMessenger.of(context)
        //   ..hideCurrentSnackBar()
        //   ..showSnackBar(snackBar);
      }


    }


  }



  ///password reset
  Future<Map<String,dynamic>?> Reset(String password,BuildContext context, String email) async{

    var response = await http.post(
      Uri.parse(BaseUrl.passReset),
      headers: {"Accept": "headers/json"},
      body:{
        "mail": encryp(email),
        "pass": encryp(password),
      }
      ,
    );

    if (response.statusCode == 200) {

      var userData = json.decode(response.body);





      if (userData == "Yes") {

        if(context.mounted){

          ///route to login page after password reset
          Navigator.pushNamed(context, Login.id);

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Password reset"),
                backgroundColor: Colors.green.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );

        }

      } else if(userData=="No"){


        if(context.mounted){

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Password reset failed"),
                backgroundColor: Colors.red.withOpacity(0.9),
                elevation: 10, //shadow
              )
          );
        }


        print(userData);
      }
    }else{

      return null;
    }



  }


  ///get order notification count
  Future getNotiCount() async {

    SharedPreferences pref= await SharedPreferences.getInstance();
    String? ID=pref.getString('cust_id');

    var response = await http.post(
        Uri.parse(BaseUrl.getOderNotiCount),
        headers: {"Accept": "headers/json"},
        body:{'id':encryp(ID!)}
    );

    if (response.statusCode == 200) {
      final data= jsonDecode(response.body);

      return data;


    } else {

      return null;
    }

  }



  ///get notifications
  Future<List<NotificationModel>?> getAllNotiii() async {

    SharedPreferences pref= await SharedPreferences.getInstance();
    String? ID=pref.getString('cust_id');

    var response = await http.post(
        Uri.parse(BaseUrl.getOderNoti),
        headers: {"Accept": "headers/json"},
        body:{'id':encryp(ID!)}
    );

    if (response.statusCode == 200) {
      return notiFromJson(
          json.decode(response.body)
      );
    } else {
      return null;
    }
  }


  ///update notifications
  Future<Map<String,dynamic>?> updateNotifications(String notid, BuildContext context) async {

    var response = await http.post(Uri.parse(BaseUrl.updateNoti),
        //headers can be left out since CORS doesn't affect apps but it will affect A flutter web app,
        //so just to be safe include them.
        headers: {"Accept": "headers/json"},
        body: {
          "id": encryp(notid),
        });


    if (response.statusCode == 200) {
      var userData = json.decode(response.body);

      // if (userData == "ye") {
      //
      //
      //
      //
      //   if(context.mounted){
      //
      //
      //     final snackBar = SnackBar(
      //       elevation: 0,
      //       behavior: SnackBarBehavior.floating,
      //       backgroundColor: Colors.transparent,
      //       content: AwesomeSnackbarContent(
      //         title: 'Failed',
      //         message:
      //         'Failed to update',
      //         contentType: ContentType.success,
      //       ),
      //     );
      //
      //     ScaffoldMessenger.of(context)
      //       ..hideCurrentSnackBar()
      //       ..showSnackBar(snackBar);
      //
      //   }
      //
      //
      // } else if(userData=="failed"){
      //
      //   if(context.mounted){
      //
      //
      //     final snackBar = SnackBar(
      //       elevation: 0,
      //       behavior: SnackBarBehavior.floating,
      //       backgroundColor: Colors.transparent,
      //       content: AwesomeSnackbarContent(
      //         title: 'Read',
      //         message:
      //         'Notification read',
      //         contentType: ContentType.warning,
      //       ),
      //     );
      //
      //     ScaffoldMessenger.of(context)
      //       ..hideCurrentSnackBar()
      //       ..showSnackBar(snackBar);
      //
      //   }
      //
      //
      //   // EasyLoading.showSuccess('Added to cart');
      //
      // }
      print(userData);
    }


  }



  ///get partners
  Future<List<PartnersModel>?> getPart() async {
    //var response = await http.get(Uri.parse(BaseUrl.category));

    var response = await http.get(
        Uri.parse(BaseUrl.getOderNotiCount),
        headers: {"Accept": "headers/json"});

    if (response.statusCode == 200) {
      return partnersFromJson(
          json.decode(response.body)
      );
    } else {
      return null;
    }
  }
}

