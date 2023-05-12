import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/themenotifier.dart';
import '../slider&productsjson/sliderjson.dart';

class SliderBanner extends StatefulWidget {
  const SliderBanner({Key? key}) : super(key: key);

  @override
  State<SliderBanner> createState() => _SliderBannerState();
}

class _SliderBannerState extends State<SliderBanner> {


  List itemsTemp = [];
  int itemLength = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      itemsTemp = slider_json;
      itemLength = slider_json.length;
    });

  }


  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemePro>(context);

    return  Container(

      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? Colors.grey.shade500: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CarouselSlider.builder(
          itemCount:itemLength,
          options:CarouselOptions(
              initialPage: 0,
              autoPlay: true,height: 150,
              onPageChanged:(int i, carouselPageChangedReason){

                setState(() {
                  itemLength=i;
                });

              }
          ), itemBuilder: (BuildContext context, int index, int realIndex) {

          // final x = slider[index];

          return  Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),

                    color: Colors.white10
                ),
                child: Image.asset(itemsTemp[index]['img'],fit: BoxFit.cover,)),
          );


        },),
      ),
    );
  }
}
