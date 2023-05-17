

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:edge_app/constants/cola.dart';
import 'package:edge_app/dashboard+Screens/ecommerce/orders/notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../providers/my_order_pro.dart';



requestNotificationPermission() async {

  //FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

}


fcmconfig({required BuildContext context}){

  FirebaseMessaging.onMessage.listen((message) {

    print("* ========== Notification========*");
    print(message.notification!.title);
    print(message.notification!.body);

    ///notification sound
    FlutterRingtonePlayer.play(fromAsset: "assets/noti/ded.mp3");
    //FlutterRingtonePlayer.play();

    /// snack back to show notification
    ///




    if(context.mounted){

      AnimatedSnackBar.rectangle(
        '${message.notification!.title}',
        '${message.notification!.body}',
        type: AnimatedSnackBarType.success,
        brightness: Brightness.light,
      ).show(context);


     // ScaffoldMessenger.of(context).showSnackBar(
     //     SnackBar(
     //       content: Text("${message.notification!.title} ${message.notification!.body}"),
     //       backgroundColor: Colors.green.withOpacity(0.9),
     //       elevation: 10, //shadow
     //     )
     // );



   }

    refreshPageNotification(message.data,context);

  });



  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    ///notification sound
    FlutterRingtonePlayer.play(fromAsset: "assets/noti/ded.mp3");
    Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationsPage()));
  });
      
}



 refreshPageNotification(data, BuildContext context) {
  print("============page id");
  print(data['pageid']);
  
  print("================pageName");
  print(data['pagename']);


  if(data['pagename']=="order"){

    final oder = Provider.of<MyOrdersProviders>(context,listen: false).refreshOrders();


  }
}


