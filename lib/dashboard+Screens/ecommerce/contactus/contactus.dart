import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../theme/theme.dart';
import '../../../theme/themenotifier.dart';

class ContactusPage extends StatefulWidget {
  const ContactusPage({Key? key}) : super(key: key);

  @override
  State<ContactusPage> createState() => _ContactusPageState();
}

class _ContactusPageState extends State<ContactusPage> {



  _callSeller(String s){
    launch(s);
  }


  please(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            //backgroundColor:themeProvider.isDarkMode ? Colors.grey.shade500 :Colors.grey.shade300,
            title: const Text('No Email Apps '),
            content: const Text('No Email Apps found'),
            actions: [

              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () {

                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );

  }

  please2(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            //backgroundColor:themeProvider.isDarkMode ? Colors.grey.shade500 :Colors.grey.shade300,
            title: const Text('No Email Apps '),
            content: const Text('No Email Apps found'),
            actions: [

              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () {

                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade400:Colors.grey[100],
        appBar:AppBar(
          backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade700:mainColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title:const Text('Contact Us',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white)),
        ),
        body:ListView(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
          children: [


              Padding(
                  padding:const EdgeInsets.only(top: 10,bottom: 10),
                child:Image.asset('assets/images/logo.png',height: 200,),
              ),


            ListTile(

              onTap: (){


                launch('tel:0800 280 040');
              },
              leading:Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                child:const Icon(CupertinoIcons.phone,color: Colors.green,size: 35,),
              ),
              title: const Text('0800 280 040',style: TextStyle(fontSize: 18),),
              trailing:const Icon(Icons.arrow_forward_ios_outlined) ,
            ),

            const SizedBox(height: 10,),

            ListTile(

              onTap: () async {

                launch('mailto:info@edgetechuganda.com?subject=Inquiry&body=');

              },

              leading:Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                child:const Icon(CupertinoIcons.mail,color: Colors.blue,size: 35,),
              ),
              title: const Text('info@edgetechuganda.com',style: TextStyle(fontSize: 18),),
              trailing:const Icon(Icons.arrow_forward_ios_outlined) ,
            ),

            const SizedBox(height: 10,),

            ListTile(

              onTap: () async {

                launch('mailto:sales@edgetchuganda.com?subject=Inquiry&body=');

              },
              leading:Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                child:const Icon(CupertinoIcons.phone,color: Colors.cyan,size: 35,),
              ),
              title: const Text('sales@edgetchuganda.com',style: TextStyle(fontSize: 18),),
              trailing:const Icon(Icons.arrow_forward_ios_outlined) ,
            ),

          ],
        ),
      ),
    );
  }



}
