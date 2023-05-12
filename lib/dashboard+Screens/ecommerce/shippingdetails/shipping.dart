import 'package:edge_app/login-signup/login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/cola.dart';
import '../../../providers/logreg.dart';
import '../../../providers/shopcartprovider.dart';
import '../../../theme/theme.dart';
import '../../../theme/themenotifier.dart';

class ShippingDetails extends StatefulWidget {

  static const  String id='shipping';

  @override
  State<ShippingDetails> createState() => _ShippingDetailsState();
}

class _ShippingDetailsState extends State<ShippingDetails> {


  final _formated= NumberFormat();


  bool positive = false;



  final _formKey=GlobalKey<FormState>();

  final _fi=TextEditingController();
  final _las=TextEditingController();
  final _phon=TextEditingController();
  final _coun=TextEditingController();
  final _add=TextEditingController();
  final _ema=TextEditingController();
  final _city=TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ShoppingCartProvider>(context,listen: false);
    });

    getPref().then((value){
      getData();
    });

  }
  String? ID,fnem,lnem,mail,phone,locat,pic,pass,count,date;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      ID= sharedPreferences.getString("cust_id");
      fnem= sharedPreferences.getString("cust_fname");
      lnem= sharedPreferences.getString("cust_lname");
      mail= sharedPreferences.getString("cust_email");
      phone= sharedPreferences.getString("cust_phone");
      locat= sharedPreferences.getString("cust_location");
      pic= sharedPreferences.getString("cust_photo");
      pass = sharedPreferences.getString("cust_password");
      count= sharedPreferences.getString("cust_country");
      date = sharedPreferences.getString("cust_created_on");

    });
  }

getData() async{

    setState(() {
      _fi.text='$fnem';
      _las.text='$lnem';
      _phon.text='$phone';
      _coun.text='$count';
      _add.text='$locat';
      _ema.text='$mail';
    });
}



  lougOut() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
      Navigator.pushReplacementNamed(context, Login.id);
    }

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
        title:const Text('Shipping Details',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white)),
      ),
        body:Consumer<ShoppingCartProvider>(
          builder: (context, value, child) {

            //ship. checkOut(amon:widget.total,context: context)


            return  Form(
              key: _formKey,
              child:ListView(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0,bottom: 10),
                    child: Center(child: Text('Where do you want your Ordered items Delivered????',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      Image.asset('assets/images/she.png',width: 115),

                      const SizedBox(height: 30,),
                    ],
                  ),


                  //first name
                  TextFormField(
                      controller: _fi,
                      cursorColor: Colors.blue.shade200,
                      decoration: InputDecoration(
                          hintText: 'First Name',
                          prefixIcon:Icon(Icons.person,size: 18,color:themeProvider.isDarkMode ? Colors.white: Colors.grey,),
                          filled: true,
                          fillColor: themeProvider.isDarkMode ? Colors.grey.shade500:Colors.grey.shade200,
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: Colors.blue),
                          )
                      ),

                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter your First Name';

                        }
                        return null;
                      }

                  ),

                  const SizedBox(height: 10,),

                  //lastname
                  TextFormField(
                      controller: _las,
                      cursorColor: Colors.blue.shade200,
                      decoration: InputDecoration(
                          hintText: 'Last Name',
                          prefixIcon: Icon(Icons.person,size: 18,color: themeProvider.isDarkMode ? Colors.white: Colors.grey,),
                          filled: true,
                          fillColor: themeProvider.isDarkMode ? Colors.grey.shade500:Colors.grey.shade200,
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: Colors.blue),
                          )
                      ),
                      validator: (value){
                        if(value!.isEmpty){

                          return 'Enter Last Name';
                        }
                        return null;

                      }
                  ),

                  const SizedBox(height: 10,),

                  //phone number
                  TextFormField(
                      controller: _phon,
                      cursorColor: Colors.blue.shade200,
                      decoration: InputDecoration(
                          hintText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone,size: 18,color: themeProvider.isDarkMode ? Colors.white: Colors.grey,),
                          filled: true,
                          fillColor: themeProvider.isDarkMode ? Colors.grey.shade500:Colors.grey.shade200,
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: Colors.blue),
                          )
                      ),

                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter your Phone Number';

                        }
                        return null;
                      }

                  ),

                  const SizedBox(height: 10,),

                  //country
                  TextFormField(
                      controller: _coun,
                      cursorColor: Colors.blue.shade200,
                      decoration: InputDecoration(
                          hintText: 'Country',
                          prefixIcon: Icon(CupertinoIcons.arrow_counterclockwise_circle_fill,size: 18,color: themeProvider.isDarkMode ? Colors.white: Colors.grey,),
                          filled: true,
                          fillColor: themeProvider.isDarkMode ? Colors.grey.shade500:Colors.grey.shade200,
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: Colors.blue),
                          )
                      ),
                      validator: (value){
                        if(value!.isEmpty){

                          return 'Enter Country';
                        }
                        return null;

                      }
                  ),

                  const SizedBox(height: 10,),

                  //address
                  TextFormField(
                      controller: _add,
                      cursorColor: Colors.blue.shade200,
                      decoration: InputDecoration(
                          hintText: 'Address',
                          prefixIcon: Icon(Icons.place,size: 18,color: themeProvider.isDarkMode ? Colors.white: Colors.grey,),
                          filled: true,
                          fillColor: themeProvider.isDarkMode ? Colors.grey.shade500:Colors.grey.shade200,
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: Colors.blue),
                          )
                      ),

                      validator: (value){
                        if(value!.isEmpty){
                          return 'Enter your Address';

                        }
                        return null;
                      }

                  ),

                  const SizedBox(height: 10,),

                  //email
                  TextFormField(
                      controller: _ema,
                      cursorColor: Colors.blue.shade200,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email,size: 18,color: themeProvider.isDarkMode ? Colors.white: Colors.grey,),
                          filled: true,
                          fillColor:themeProvider.isDarkMode ? Colors.grey.shade500:Colors.grey.shade200,
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: Colors.blue),
                          )
                      ),
                      validator: (value){
                        if(value!.isEmpty){

                          return 'Enter Email';
                        }
                        bool _isValid= (EmailValidator.validate(value));
                        if(_isValid==false){
                          return 'Enter Valid Email Address';

                        }
                        return null;

                      }
                  ),

                  const SizedBox(height: 10,),



                  //sign up
                  Consumer<ShoppingCartProvider>(
                      builder: (context, ship, child) {

                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                              colors:[
                                blueGradient.darkShade,
                                blueGradient.lightShade,
                              ],
                            ),
                          ),
                          child: MaterialButton(
                            //color: Colors.green.shade700,
                            child:const Text("Continue",style: TextStyle(color: Colors.white),),
                            onPressed: () {



                              if(_formKey.currentState!.validate()){

                                if (_fi.text !='' ||
                                    _las.text !='' ||
                                    _phon.text !=''||
                                    _add.text !='' ||
                                    _ema.text !=''||
                                    _coun.text !='') {


                                  //ship. checkOut(context: context);

                                  //add shipping details
                                  ship.addShip(
                                      firstName: _fi.text,
                                      lastName: _las.text,
                                      email: _ema.text,
                                      address:_add.text,
                                      phone:_phon.text,
                                      country:_coun.text,
                                      context: context);

                                }

                              }

                            },
                          ),
                        );

                      }),

                  const SizedBox(height: 20,),



                ],
              ),
            );
          }),
        ),
    );
  }
}
