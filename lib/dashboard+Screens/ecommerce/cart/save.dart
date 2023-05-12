import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
class SaveForLater extends StatefulWidget {
  const SaveForLater({Key? key}) : super(key: key);

  @override
  State<SaveForLater> createState() => _SaveForLaterState();
}

class _SaveForLaterState extends State<SaveForLater> {
  @override
  Widget build(BuildContext context) {


    //final _productsProvider=Provider.of<ProductProvider>(context);

    return InkWell(
      onTap: ()
      async {

        EasyLoading.showSuccess('Save Clicked');

        //
        // EasyLoading.show(status: 'Saving....');
        //
        // var response=await http.post(Uri.parse('https://mymusawoee.000webhostapp.com/api/owner/favourite.php'),
        //     body:{
        //       "me_id":'$userID',
        //       "product":_productsProvider.Pro,
        //
        //     });
        //
        // if(response.statusCode==200){
        //
        //   EasyLoading.showSuccess('Saved Successfully');
        //
        //
        // }else {
        //   EasyLoading.showError('Failed to save');
        // }
      },

      child:Container(
        height:56 ,
        decoration: const BoxDecoration(
          color:Colors.black54,
        ),
        child: Center(child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(CupertinoIcons.bookmark,color: Colors.white,),
            SizedBox(width: 4,),
            Text('Save',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          ],
        ),
        ),
      ),
    );
  }
}
