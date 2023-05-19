
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/cola.dart';
import '../../../providers/shopcartprovider.dart';
import '../../../theme/theme.dart';
import '../../../theme/themenotifier.dart';

class PaymentMethod extends StatefulWidget {

  static const  String id='payment';

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {

  final List<String> _radioValue=['Debit/Credit Card','Cash on Delivery','PayPal','MTN MobileMoney','AirtelMoney'];
   String _selected="Cash on Delivery";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Provider.of<ShoppingCartProvider>(context,listen: false);

    });
  }


  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemePro>(context);

    return WillPopScope(
        child:Scaffold(
          appBar: AppBar(
            backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade700:mainColor,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            title:const Text('Payment Method',maxLines: 1,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white)),
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
                child:  const ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/favi.png'),
                  ),
                  title: Text('Choose your payment method',style: TextStyle(fontSize: 20),),
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


                    for(int i=0; i< _radioValue.length; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                              value:_radioValue[i].toString(),
                              groupValue:_selected,
                              onChanged:(value){
                                setState(() {
                                  _selected=value.toString();
                                });
                              }
                          ),

                          const SizedBox(width: 40,),

                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child:Text(_radioValue[i],style: const TextStyle(fontSize: 15),),
                                ),

                                const SizedBox(width: 10,),

                                Expanded(
                                  child:Padding(
                                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                                    child:Row(
                                      children: [
                                        _radioValue[i]=="Debit/Credit Card" ? Image.asset('assets/images/credit-card.png',height: 50,width: 50,):
                                        _radioValue[i]=="Cash on Delivery" ? Image.asset('assets/images/cash-on-delivery.png',height: 50,width: 50,):
                                        _radioValue[i]=="PayPal" ? Image.asset('assets/images/paypal.png',height: 50,width: 50,):
                                        _radioValue[i]=="MTN MobileMoney" ? Image.asset('assets/images/mobilemoney.png',height: 50,width: 50,):
                                        Image.asset('assets/images/airtel.jpg',height: 50,width: 50,),
                                      ],
                                    ) ,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),



                  ],
                ),
              ),



              const Divider(thickness: 5,),

              const SizedBox(height: 40,),

              //// payments
              Consumer<ShoppingCartProvider>(
                builder: (context,out,child){

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
                      child:const Text("Pay",style: TextStyle(color: Colors.white),),
                      onPressed: () {

                        if(_selected=="Cash on Delivery"){


                          out.checkOut(method:_selected.toString(),context: context);

                        }else{


                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor:Colors.blue.withOpacity(0.5),
                                title: Row(
                                  children: [
                                    _selected=="Debit/Credit Card" ? Image.asset('assets/images/credit-card.png',height: 50,width: 50,):
                                    _selected=="PayPal" ? Image.asset('assets/images/paypal.png',height: 50,width: 50,):
                                    _selected=="MTN MobileMoney" ? Image.asset('assets/images/mobilemoney.png',height: 50,width: 50,):
                                    Image.asset('assets/images/airtel.jpg',height: 50,width: 50,),
                                  ],
                                ),
                                content:  Text('${_selected} payment will integrated soon!!!',style: TextStyle(color: Colors.white),),
                                actions: [
                                  Container(
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
                                      child:const Text("Cancel",style: TextStyle(color: Colors.white),),
                                      onPressed: () {

                                        Navigator.pop(context);

                                      },
                                    ),
                                  ),

                                ],
                              );
                            },
                          );



                        }


                      },
                    ),
                  );
                },
              ),
              //payment


            ],
          ),
        ),
      onWillPop:() async{

        return false;
      },
    );
  }
}
