
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/cola.dart';
import '../../login-signup/login.dart';
import '../../theme/theme.dart';
import '../../theme/themenotifier.dart';



class CartPro extends StatefulWidget {
  const CartPro({Key? key}) : super(key: key);

  @override
  State<CartPro> createState() => _CartProState();
}

class _CartProState extends State<CartPro> {

  String? userID;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {


    final themeProvider = Provider.of<ThemePro>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade700:mainColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Cart'),
        //title:const Text('Cart',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white)),
      ),

      backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100],
      body: Padding(
          padding: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 60),
          child:Container(
            decoration:const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/empty.png',),fit: BoxFit.contain
                )

            ),
            child: Center(
              child:Container(
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
                  child:const Text("Login",style: TextStyle(color: Colors.white),),
                  onPressed: () {

                    Navigator.pushNamed(context, Login.id);

                  },
                ),
              ),
            ),
          ),
        ),
    );
  }
}
