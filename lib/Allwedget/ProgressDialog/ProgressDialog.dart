

import 'package:flutter/material.dart';




// ignore: must_be_immutable
class ProgressDialog extends StatelessWidget {
  String message;
  ProgressDialog({this.message});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
//        margin: EdgeInsets.all(15.0),
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Color(0xFFbcbcbc),
              borderRadius: BorderRadius.circular(6.0),),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          SizedBox(height: 6.0,),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),

          ),
          SizedBox(height:26.0,),
          Text(message,style: TextStyle(color: Colors.black,fontSize: 10.0),)

        ],),

      ),
    );
  }
}
