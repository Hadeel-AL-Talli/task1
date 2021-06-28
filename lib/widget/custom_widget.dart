import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textFeild(
    {@required TextEditingController controller,
   @required TextInputType type,
    @required Function validate,
    @required String hint, 
    InputDecoration decoration,
    
    
   }) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.only(right: 30),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(25),
    ),
    child: TextFormField(
        keyboardType: type,
        controller: controller,
        decoration: InputDecoration(
          
            hintText: hint,
            contentPadding: EdgeInsets.only(left: 20),
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            border: InputBorder.none),
        validator: validate),
  );
}
