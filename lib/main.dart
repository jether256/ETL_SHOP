import 'dart:io';

import 'package:edge_app/dashboard+Screens/dashboard.dart';
import 'package:edge_app/dashboard+Screens/ecommerce/checkout/checkout.dart';
import 'package:edge_app/dashboard+Screens/ecommerce/homepro.dart';
import 'package:edge_app/dashboard+Screens/ecommerce/paymentmethods/paymentmethod.dart';
import 'package:edge_app/dashboard+Screens/ecommerce/shippingdetails/shipping.dart';
import 'package:edge_app/firebase_options.dart';
import 'package:edge_app/firstpages/onboard.dart';
import 'package:edge_app/firstpages/splash.dart';
import 'package:edge_app/login-signup/check%20verificationcode.dart';
import 'package:edge_app/login-signup/forgotpass.dart';
import 'package:edge_app/login-signup/login.dart';
import 'package:edge_app/login-signup/signup.dart';
import 'package:edge_app/providers/categoryproductprovider.dart';
import 'package:edge_app/providers/catprovider.dart';
import 'package:edge_app/providers/favoritepro.dart';
import 'package:edge_app/providers/featuredprovider.dart';
import 'package:edge_app/providers/logreg.dart';
import 'package:edge_app/providers/my_order_pro.dart';
import 'package:edge_app/providers/orderdetailsprovider.dart';
import 'package:edge_app/providers/partnerspro.dart';
import 'package:edge_app/providers/productprovider.dart';
import 'package:edge_app/providers/shopcartprovider.dart';
import 'package:edge_app/providers/subcategoryprovider.dart';
import 'package:edge_app/theme/themenotifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'dashboard+Screens/ecommerce/cartwidget/cartwidget.dart';
import 'dashboard+Screens/ecommerce/homepagewidgets/cartwidget.dart';
import 'dashboard+Screens/ecommerce/homepagewidgets/clientslider.dart';
import 'dashboard+Screens/ecommerce/homepagewidgets/proei.dart';
import 'login-signup/loginCheck.dart';



bool? darkMode=false;

///allows all certificates good for production mode but not for production mode
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;




 main() async {

   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options:DefaultFirebaseOptions.currentPlatform
   );

   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

   if (!kIsWeb) {
     await setupFlutterNotifications();
   }
          ///allows all certificates good for production mode but not for production mode
   // HttpOverrides.global = new MyHttpOverrides();

   ///handles expired certificate issues in flutter but expired in 2021..
   ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
   SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());

  Provider.debugCheckInvalidValueType=null;

  await GetStorage.init();
  runApp(


    //providers
    MultiProvider(
      providers: [



        //user provider
        ChangeNotifierProvider(
          create:(_) => UserProvider(),
        ),

        //theme provider
        ChangeNotifierProvider(
          create:(_) => ThemePro(),
        ),

        //categories provider
        ChangeNotifierProvider(
          create:(_) => CategoriesProvider(),
          child:const CategoryWidget(),
        ),


        ChangeNotifierProvider(
          create:(_) => ProductProvider(),
          child:const ProWid(),
        ),

        ChangeNotifierProvider(
          create:(_) => PartnersProvider(),
          child:const ClientSlider(),
        ),

        ChangeNotifierProvider(
          create:(_) => CategoryProductProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => SubCatProductProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => FeaturedProvider(),
        ),

        ChangeNotifierProvider(
          create:(_) => ShoppingCartProvider(),
         // child: const CartWidget(),
        ),

        ChangeNotifierProvider(
          create:(_) => MyOrdersProviders(),
          // child: const CartWidget(),
        ),

        //FavouriteProvider

        ChangeNotifierProvider(
          create:(_) => MyOrdersDetailsProviders(),
          // child: const CartWidget(),
        ),

        ChangeNotifierProvider(
          create:(_) => FavouriteProvider(),
          // child: const CartWidget(),
        ),

      ],
      child: const MyApp(),
    ),

  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final theme=Provider.of<ThemePro>(context);

    return MaterialApp(
      title: 'Edge App',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primaryColor: mainColor,
      //   fontFamily: 'Gothic',
      // ),
      themeMode: theme.themeMode,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      builder:EasyLoading.init(),
        initialRoute: SplashScreen.id,
        //routes
        routes: {
          SplashScreen.id:(context)=>SplashScreen(),
          OnBoarding.id:(context)=>const OnBoarding(),
          Dashboard.id:(context)=>Dashboard(),
          Login.id:(context)=>Login(),
          SignUp.id:(context)=>SignUp(),
          HomeProduct.id:(context)=>const HomeProduct(),
          ShippingDetails.id:(context)=>ShippingDetails(),
          Checkout.id:(context)=>Checkout(),
          PaymentMethod.id:(context)=>PaymentMethod(),
          //ForgotPassword.id:(context)=>ForgotPassword(),
          // LoginCheckCode.id:(context)=>LoginCheckCode(mail: '',),
          //CheckCode.id:(context)=>CheckCode(),
    },
    );
  }
}

