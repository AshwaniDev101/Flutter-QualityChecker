import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextStyles {

  static const TextStyle top_row = TextStyle(
      color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold,);
  static const TextStyle bottom_row = TextStyle(
      color: Colors.black54, fontSize: 14, fontWeight: FontWeight.bold);

  static const TextStyle row_index = TextStyle(
      color: Colors.black54, fontSize: 14, fontWeight: FontWeight.bold,);

}

class MyColors {
  static const Color top_row = Colors.blue;
  static  Color field_background = Colors.grey.shade50;
  static  Color field_blue_light = Colors.lightBlue.shade50;
}

class MyDecorations {
  static InputDecoration field_input = InputDecoration(
      border: const OutlineInputBorder(),
    filled: true,
    fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(

        borderRadius: BorderRadius.circular(5),
       // borderSide: BorderSide.none,
        borderSide: BorderSide(
          color: Colors.grey.shade400,
          width: 1.0,
        ),
      ),


      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),

  );

  static InputDecoration field_input_disable = InputDecoration(

   disabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.circular(5),
     //borderSide: BorderSide.none,
     borderSide: BorderSide(
       color: Colors.blue.shade100,
       width: 1,
     ),
   ),
   filled: true,
   fillColor: MyColors.field_blue_light,//Color(0xff434242),


    contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),

  );


}